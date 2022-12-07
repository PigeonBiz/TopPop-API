# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class SearchVideos
      include Dry::Transaction

      step :get_youtube_videos
      step :create_video_list

      private

      API_ERR_MSG = 'Having trouble accessing the youtube API'
      LIST_ERR_MSG = 'Having trouble creating video list'

      def get_youtube_videos(search_keyword)
        result_videos = Youtube::SearchMapper
                          .new(App.config.ACCESS_TOKEN)
                          .search(search_keyword, 10)
                          .videos  
        Success(result_videos)
      rescue StandardError
        Failure(
          Response::ApiResult.new(status: :internal_error, message: API_ERR_MSG)
        )
      end

      def create_video_list(video_entities)
        video_list = Response::VideosList.new(video_entities)
        Success(Response::ApiResult.new(status: :ok, message: video_list))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: LIST_ERR_MSG))
      end
    end
  end
end
