# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class SearchVideos
      include Dry::Transaction

      step :get_youtube_videos

      private

      def get_youtube_videos(search_keyword)
        searched_videos = Youtube::SearchMapper
                          .new(App.config.ACCESS_TOKEN)
                          .search(search_keyword, 10)
                          .videos  
        Success(searched_videos)
      rescue StandardError => error
        App.logger.error error.backtrace.join("\n")
        Failure('Having trouble accessing youtube API')
      end
    end
  end
end
