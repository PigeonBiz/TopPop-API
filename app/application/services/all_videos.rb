# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AllVideos
      include Dry::Transaction

      step :get_all_videos
<<<<<<< HEAD
      step :reify_videos

      private
      
      def get_all_videos()
        result_videos = Gateway::Api.new(TopPop::App.config)
          .get_all_videos()
        result_videos.success? ? Success(result_videos.payload) : Failure(result_videos.message)
      rescue StandardError => e
        puts e.inspect
        puts e.backtrace
        Failure('Cannot get videos right now; please try again later')
      end

      def reify_videos(videos_json)
        Representer::Videos.new(OpenStruct.new)
          .from_json(videos_json)
          .then { |videos| Success(videos) }
      rescue StandardError
        Failure('Error in parsing videos; please try again later')
=======
      step :create_video_list

      private

      GET_ERR_MSG = 'Having trouble getting all db videos'
      PARSE_ERR_MSG = 'Having trouble creating video list'

      def get_all_videos()
        result_videos = Repository::Videos.all
        Success(result_videos)
      rescue StandardError
        Failure(
          Response::ApiResult.new(status: :internal_error, message: GET_ERR_MSG)
        )
      end

      def create_video_list(video_entities)
        video_list = Response::VideosList.new(video_entities)
        Success(Response::ApiResult.new(status: :ok, message: video_list))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: PARSE_ERR_MSG))
>>>>>>> 5d0f626fbf32d631e1eb6300bc78219b54848dfc
      end
    end
  end
end
