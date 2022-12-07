# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AddVideos
      include Dry::Transaction

      step :add_videos

      private

      DB_ERR_MSG = 'Having trouble accessing the database'

      # Add unique videos to database
      def add_videos(videos)
        added_video = videos.map {|video| Repository::Videos.create(video)}
        Success(Response::ApiResult.new(status: :created, message: added_video))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: DB_ERR_MSG))
      end
    end
  end
end
