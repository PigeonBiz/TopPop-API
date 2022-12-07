# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AddVideo
      include Dry::Transaction

      step :find_video
      step :store_video

      private

      DB_ERR_MSG = 'Having trouble accessing the database'
      DB_ADD_ERR_MSG = 'Having trouble adding video to the database'

      def find_video(input)
        if (video = video_in_database(input))
          input[:local_video] = video
        else
          input[:remote_video] = video
        end
        Success(input)
      rescue StandardError => e
        Failure(Response::ApiResult.new(status: :not_found, message: DB_ERR_MSG))
      end

      def store_video(input)
        video =
          if (new_vid = input[:remote_video])
            Repository::For.entity(new_vid).create(new_vid)
          else
            input[:local_video]
          end
        Success(Response::ApiResult.new(status: :created, message: video))
      rescue StandardError => e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: DB_ADD_ERR_MSG))
      end

      # Support methods for steps

      def video_in_database(video)
        Repository::For.klass(Entity::Video).find(video)
      end
    end
  end
end
