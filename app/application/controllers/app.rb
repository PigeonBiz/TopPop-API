# frozen_string_literal: true

require 'roda'
require 'rack'

module TopPop
  # Web App
  class App < Roda
    plugin :render, views: 'app/presentation/views_html'
    plugin :assets, path: 'app/presentation/assets', css: 'style.css'
    plugin :common_logger, $stderr
    plugin :halt
    plugin :flash
    plugin :all_verbs # allows HTTP verbs beyond GET/POST (e.g., DELETE)
    plugin :common_logger, $stderr

    use Rack::MethodOverride 

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      routing.root do
        # GET /
        view 'home'
      end

      # Virtual route to verify and save player's input 
      routing.on 'player' do
        routing.is do
          # POST /player
          routing.post do
            # Get player name
            player_name_monad = Forms::PlayerName.new.call(routing.params)
            input_verified = Service::VerifyInput.new.call(player_name_monad)

            if input_verified.failure?
              flash[:error] = input_verified.failure
              routing.redirect '/'
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
          # GET /search/
          routing.get do
            # Get cookie viewer's previously seen videos
            session[:watching] ||= []        
            
            # Load previously viewed videos
            videos = Repository::For.klass(Entity::Video)
              .find_video_ids(session[:watching])
      
            session[:watching] = videos.map(&:get_video_id)
      
            if videos.none?
              flash.now[:notice] = 'Search a keyword to get started'
            end
      
            viewable_videos = Views::VideoList.new(videos)
      
            view 'search', locals: { videos: viewable_videos }
          end

          # POST /search/
          routing.post do
            yt_search_keyword = routing.params['search_keyword'].downcase
            yt_search_keyword.gsub!(' ', '%20')
            
            # Return 5 video entities
            searched_videos = Youtube::SearchMapper
                             .new(App.config.ACCESS_TOKEN)
                             .search(yt_search_keyword, 5)
                             .videos                            

            # Add unique videos to database
            begin
              searched_videos.map {|video| Repository::Videos.create(video)}
            rescue StandardError => err
              logger.error err.backtrace.join("\n")
              flash[:error] = 'Having trouble accessing the database'
            end

            # Add new video ids to watched set in cookies
            searched_videos.map do |video|     
              session[:watching].insert(0, video.get_video_id).uniq!
            end

            # Redirect viewer to search page      
            routing.redirect "search/#{yt_search_keyword}"
          end
        end

        routing.on String do |yt_search_keyword|
          # GET /search/keyword    
          routing.get do
            # Show the seached videos 
            searched_videos = Repository::For.klass(Entity::Video)
            .find_video_ids(session[:watching].first(5))

            viewable_searched_videos = Views::VideoList.new(searched_videos)
            view 'searched_videos', locals: { videos: viewable_searched_videos }
          end
        end        
      end
      
      routing.on 'video' do
        routing.on String do |video_id|
          # DELETE /video/video_id
          routing.get do
            session[:watching].delete(video_id)
  
            routing.redirect '/'
          end          
        end
      end 
    end
  end
end
