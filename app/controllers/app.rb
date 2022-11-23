# frozen_string_literal: true

require 'roda'

module TopPop
  # Web App
  class App < Roda
    plugin :render, views: 'app/views'
    plugin :assets, css: 'style.css', path: 'app/views/assets'
    plugin :common_logger, $stderr
    plugin :halt

    route do |routing|
      routing.assets # load CSS
      response['Content-Type'] = 'text/html; charset=utf-8'

      # GET /
      routing.root do
        videos = Repository::Videos.all
        view 'home', locals: { videos: }
      end

      routing.on 'search' do
        routing.is do
          # POST /search/
          routing.post do
            yt_search_keyword = routing.params['search_keyword'].downcase
            yt_search_keyword.gsub!(' ', '%20')
            
            # Get video from Github
            youtube_search = Youtube::SearchMapper
                             .new(App.config.ACCESS_TOKEN)
                             .search(yt_search_keyword, 5)                            

            # Add video to database
            youtube_search.videos.map {|video| Repository::Videos.create(video)}
            
            # Redirect viewer to search page      
            routing.redirect "search/#{yt_search_keyword}"
          end
        end

        routing.on String do |yt_search_keyword|
          # GET /search/keyword
          routing.get do
            # Get videos from database
            videos = Repository::Videos.all
            view 'search', locals: { videos: }
          end
        end
      end
    end
  end
end
