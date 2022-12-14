# frozen_string_literal: true

require 'roda'
require 'rack'

module TopPop
  # Web App
  class App < Roda
    plugin :halt
    plugin :all_verbs 
    plugin :common_logger, $stderr

    use Rack::MethodOverride 

    route do |routing|
      response['Content-Type'] = 'application/json'

      # GET /
      routing.root do
        message = "TopPop API v1 at /api/v1/ in #{App.environment} mode"

        result_response = Representer::HttpResponse.new(
          Response::ApiResult.new(status: :ok, message: message)
        )

        response.status = result_response.http_status_code
        result_response.to_json
      end

      routing.on 'api/v1' do
        routing.on 'search' do
          routing.on String do |search_keyword|
            # GET /search/search_keyword
            routing.get do
              result = Service::SearchVideos.new.call(search_keyword)

              if result.failure?
                failed = Representer::HttpResponse.new(result.failure)
                routing.halt failed.http_status_code, failed.to_json
              end

              http_response = Representer::HttpResponse.new(result.value!)
              response.status = http_response.http_status_code

              Representer::Videos.new(
                result.value!.message
              ).to_json
            end

            # Save player name into cookie
            player_name = player_name_monad.to_h[:player_name]
            session[:player_name] = player_name

            flash[:notice] = "Hi #{player_name}! Welcome to TopPop!"

            routing.redirect "game"
          end
        end      
      end

      routing.on 'game' do
        routing.is do
          # GET /game
          view 'game'
        end      
      end

      routing.on 'search' do
        routing.is do
          # GET /search
          routing.get do
            get_all_videos = Service::AllVideos.new.call()

            if get_all_videos.failure?
              flash[:error] = get_all_videos.failure
              routing.redirect '/'
            end

            all_videos = get_all_videos.value!.videos
            viewable_videos = Views::VideoList.new(all_videos)      
            view 'search', locals: { videos: viewable_videos }
          end

          # POST /search
          routing.post do
            search_keyword = routing.params['search_keyword']
            
            # Redirect viewer to search result page      
            routing.redirect "search/#{search_keyword}"
          end
        end
        
        routing.on String do |search_keyword|
          # GET /search/{search_keyword}
          routing.get do    
            search_keyword_monad = Forms::SearchKeyword.new.call({:search_keyword => search_keyword})
            search_result = Service::SearchVideos.new.call(search_keyword_monad)
    
            if search_result.failure?
              flash[:error] = search_result.failure
              routing.redirect '/search'
            end

            searched_videos = search_result.value!.videos
            viewable_searched_videos = Views::VideoList.new(searched_videos)
            view 'searched_videos', locals: { videos: viewable_searched_videos }
          end
        end        
      end
    end
  end
end
