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
        view 'home'
      end

      routing.on 'search' do
        routing.is do
          # POST /search/
          routing.post do
            yt_search_keyword = routing.params['search_keyword'].downcase
            yt_search_keyword.gsub!(' ', '%20')

            routing.redirect "search/#{yt_search_keyword}"
          end
        end

        routing.on String do |keyword|
          # GET /search/keyword
          routing.get do
            youtube_search = Youtube::SearchMapper
                             .new(YOUTUBE_TOKEN)
                             .search(keyword, 5)

            view 'search', locals: { search: youtube_search }
          end
        end
      end
    end
  end
end
