# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AllVideos
      include Dry::Transaction

      step :get_all_videos
      step :create_video_list

      private

      GET_ERR_MSG = 'Having trouble getting all db videos'
      PARSE_ERR_MSG = 'Having trouble creating video list'

      def get_all_videos()
        result_videos = Repository::Videos.all
        Success(result_videos)
      rescue StandardError => e 
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: GET_ERR_MSG))
      end

      def create_video_list(video_entities)
        video_list = Response::VideosList.new(video_entities)
        Success(Response::ApiResult.new(status: :ok, message: video_list))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: PARSE_ERR_MSG))
      end
    end
  end
end
