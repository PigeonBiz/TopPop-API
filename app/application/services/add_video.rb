# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AddVideo
      include Dry::Transaction

      step :add_video

      private

      FOUND_MSG = ' already existed in the database'
      ADDED_MSG = ' added to the database'
      BUILD_ERR_MSG = 'Having trouble building video entity'
      ADD_ERR_MSG = 'Having trouble adding video to the database'

      def add_video(video_id)
        if (video = video_in_database(video_id))
          Success(Response::ApiResult.new(
            status: :created, 
            message: "#{video.title} #{FOUND_MSG}"
          ))
        else
          video_entity = video_from_youtube(video_id)
          added_video = Repository::For.entity(video_entity).create(video_entity)
          Success(Response::ApiResult.new(
            status: :created, 
            message: "#{added_video.title} #{ADDED_MSG}"
          ))
        end
      rescue StandardError => e
        puts e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: ADD_ERR_MSG))
      end

      # Support methods for steps

      def video_from_youtube(video_id)
        Youtube::VideoMapper.new(App.config.ACCESS_TOKEN, video_id).build_vid
      rescue StandardError => e
        puts e
        puts e.backtrace.join("\n")
        Failure(Response::ApiResult.new(status: :internal_error, message: BUILD_ERR_MSG))
      end

      def video_in_database(video_id)
        Repository::For.klass(Entity::Video).find_video_id(video_id)
      end
    end
  end
end
