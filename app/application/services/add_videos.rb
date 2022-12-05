# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    class AddVideos
      include Dry::Transaction

      step :add_videos

      private

      # Add unique videos to database
      def add_videos(videos)
        videos.map {|video| Repository::Videos.create(video)}
      rescue StandardError => error
        App.logger.error error.backtrace.join("\n")
        Failure('Having trouble accessing the database')
      end
    end
  end
end
