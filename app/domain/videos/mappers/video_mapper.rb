# frozen_string_literal: true

module TopPop
  # Provides access to video data
  module Youtube
    # Data Mapper: Youtube search -> Video entity
    class VideoMapper
      def initialize(yt_token, videos_data, gateway_class = Youtube::Api)
        @yt_token = yt_token
        @videos_data = videos_data
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      def build2vid
        @videos_data.map do |video_data|
          video_information = @gateway.video_data(video_data['id']['videoId'])
          VideoMapper.build_entity(video_information['items'][0])
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
            channel_title:,
            view_count:,
            like_count:,
            comment_count:
          )
        end

        private

        def video_id
          @video_data['id']
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

        def view_count
          @video_data['statistics']['viewCount'].to_i
        end

        def like_count
          @video_data['statistics']['likeCount'].to_i
        end

        def comment_count
          @video_data['statistics']['commentCount'].to_i
        end
      end
    end
  end
end
