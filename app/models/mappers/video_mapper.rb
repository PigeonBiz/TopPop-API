# frozen_string_literal: false

module YoutubeInformation
  # Provides access to video data
  module Youtube
    # Data Mapper: Youtube search -> Video entity
    class VideoMapper
      def initialize(videos_data)
        @videos_data = videos_data
      end

      def build2vid
        @videos_data.map do |video_data|
          VideoMapper.build_entity(video_data)
        end
      end

      def self.build_entity(video_data)
        DataMapper.new(video_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(video_data)
          @video_data = video_data
        end

        def build_entity
          Entity::Video.new(
            video_id:,
            title:,
            publish_date:,
            channel_title:
          )
        end

        private

        def video_id
          @video_data['id']['videoId']
        end

        def title
          @video_data['snippet']['title']
        end

        def publish_date
          @video_data['snippet']['publishedAt']
        end

        def channel_title
          @video_data['snippet']['channelTitle']
        end
      end
    end
  end
end
