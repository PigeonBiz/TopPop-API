# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class DeleteVideo
      include Dry::Transaction

      step :delete_video

      private

      DELETED_MSG = 'Video deleted from db'
      NOT_FOUND_MSG = 'The video does not exist in db'
      DELETE_ERR_MSG = 'Having trouble deleting video from the database'

      def delete_video(video_id)
        if (video_in_database(video_id))
          Repository::For.klass(Entity::Video).delete(video_id)
          Success(Response::ApiResult.new(status: :ok, message: DELETED_MSG))
        else
          Success(Response::ApiResult.new(status: :not_found, message: NOT_FOUND_MSG))
        end
      rescue StandardError => e
        puts e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: DELETE_ERR_MSG))
      end

      # Support methods for steps

      def video_in_database(video_id)
        Repository::For.klass(Entity::Video).find_video_id(video_id)
      end
    end
  end
end
