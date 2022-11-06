# frozen_string_literal: true

require 'roda'

module YoutubeInformation
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
        view 'home',locals: { videos: }
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

            channel_title = youtube_search.videos.first.channel_title
            # Add video to database
            rebuilt = youtube_search.videos.map {|video|  YoutubeInformation::Repository::Videos.create(video)}
            
            # Redirect viewer to video page      
            routing.redirect "search/#{channel_title}"
          end
        end

        routing.on String do |channel_title|
          # GET /search/keyword
          routing.get do
            # Get videos from database
            #chennelvideo = Repository::Videos
            #  .find_full(channel_title)
            videos = Repository::Videos.all
            view 'search', locals: { videos: }
          end
        end
      end
    end
  end
end
