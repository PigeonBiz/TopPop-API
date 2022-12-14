# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class SearchVideos
      include Dry::Transaction

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
      end
    end
  end
end
