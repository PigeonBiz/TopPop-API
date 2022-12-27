# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AllDailyVideos
      include Dry::Transaction

      step :get_all_daily_videos
      step :create_video_list

      private

      GET_ERR_MSG = 'Having trouble getting all db daily videos'
      PARSE_ERR_MSG = 'Having trouble creating daily video list'

      def get_all_daily_videos()
        result_videos = Repository::DailyVideos.all
        Success(result_videos)
      rescue StandardError
        Failure(
          Response::ApiResult.new(status: :internal_error, message: GET_ERR_MSG)
        )
      end

      def create_video_list(video_entities)
        daily_video_list = Response::VideosList.new(video_entities)
        Success(Response::ApiResult.new(status: :ok, message: daily_video_list))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: PARSE_ERR_MSG))
      end
    end
  end
end
