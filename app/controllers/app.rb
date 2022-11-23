# frozen_string_literal: true

require 'roda'

module YoutubeInformation
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

      # GET /
      routing.root do
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

        view 'home', locals: { videos: viewable_videos }
      end

      routing.on 'search' do
        routing.is do
          # POST /search/
          routing.post do
            yt_search_keyword = routing.params['search_keyword'].downcase
            yt_search_keyword.gsub!(' ', '%20')
            
            # Get video from Youtube
            youtube_search = Youtube::SearchMapper
                             .new(App.config.ACCESS_TOKEN)
                             .search(yt_search_keyword, 5)                            

            # Add video to database
            begin
              youtube_search.videos.map {|video| Repository::Videos.create(video)}
            rescue StandardError => err
              logger.error err.backtrace.join("\n")
              flash[:error] = 'Having trouble accessing the database'
            end

            # Add new video ids to watched set in cookies
            youtube_search.videos.map do |video|     
              session[:watching].insert(0, video.get_video_id).uniq!
            end

            # Redirect viewer to search page      
            routing.redirect "search/#{yt_search_keyword}"
          end
        end

        routing.on String do |yt_search_keyword|
          # GET /search/keyword    
          routing.get do
            # Get 5 lastest videos from database
            videos = Repository::Videos.all.last(5)
            view 'search', locals: { videos: }
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
