# frozen_string_literal: true

require "date"

module TopPop
  # Provides access to video data
  module Youtube
    class VideoMapper
      def initialize(yt_token, videos_data, gateway_class = Youtube::Api)
        @yt_token = yt_token
        @videos_data = videos_data
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      # build list of video entities from search result
      def build_vid_list
        @videos_data.map do |video_data|
          video_information = @gateway.video_data(video_data['id']['videoId'])
          VideoMapper.build_entity(video_information['items'][0])
        end
      end

      # build a single video entity from video id (as @videos_data)
      def build_vid
        video_information = @gateway.video_data(@videos_data)
        VideoMapper.build_entity(video_information['items'][0])
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
            view_count:
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
          raw_date = @video_data['snippet']['publishedAt']
          Date.parse(raw_date).strftime("%m/%d/%Y")
        end

        def channel_title
          @video_data['snippet']['channelTitle']
        end

        def view_count
          @video_data['statistics']['viewCount'].to_i
        end
      end
    end
  end
end
