# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class SearchVideos
      include Dry::Transaction

<<<<<<< HEAD
      step :get_youtube_videos
      step :create_video_list

      private

      GET_ERR_MSG = 'Having trouble accessing the youtube API'
      PARSE_ERR_MSG = 'Having trouble creating video list'

      def get_youtube_videos(search_keyword)
        result_videos = Youtube::SearchMapper
                          .new(App.config.ACCESS_TOKEN)
                          .search(search_keyword, 10)
                          .videos  
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
<<<<<<< HEAD
        Failure(Response::ApiResult.new(status: :internal_error, message: LIST_ERR_MSG))
=======
      step :verify_input
      step :get_youtube_videos
      step :reify_videos

      private

      def verify_input(input)
        if input.success?
          Success(input)
        else
          Failure(input.errors.values.join('; '))
        end
      end

      def get_youtube_videos(input)
        result_videos = Gateway::Api.new(TopPop::App.config)
          .search_videos(input[:search_keyword])
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
>>>>>>> a2440d7d58116bd0838227d3a9b072554878a1ad
=======
        Failure(Response::ApiResult.new(status: :internal_error, message: PARSE_ERR_MSG))
>>>>>>> 5d0f626fbf32d631e1eb6300bc78219b54848dfc
      end
    end
  end
end
