# frozen_string_literal: false

module YoutubeInformation
  # Provides access to video data
  module Youtube
    # Data Mapper: Youtube search -> Video entity
    class VideoMapper
      def initialize(yt_token, gateway_class = Youtube::Api)
        @yt_token = yt_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      def load_several(url)
        @gateway.videos_data(url).map do |data|
          VideoMapper.build_entity(data)
        end
      end

      def self.build_entity(data)
        DataMapper.new(data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data)
          @data = data
        end

        def build_entity
          Entity::Member.new(
            id:,
            title:,
            publish_date:,
            channel_title:
          )
        end

        private

        def id
          @data['id']['videoId']
        end

        def title
          @data['snippet']['title']
        end

        def publish_date
          @data['snippet']['publishedAt']
        end

        def channel_title
          @data['snippet']['channelTitle']
        end
      end
    end
  end
end
