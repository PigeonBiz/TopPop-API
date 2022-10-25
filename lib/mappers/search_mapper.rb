# frozen_string_literal: false

require_relative 'video_mapper'

module YoutubeInformation
  module Youtube
    # Data Mapper: Github repo -> Project entity
    class ProjectMapper
      def initialize(yt_token, gateway_class = Youtube::Api)
        @yt_token = yt_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      def find(keyword)
        data = @gateway.search_data(keyword)
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data, @yt_token, @gateway_class).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data, yt_token, gateway_class)
          @data = data
          @video_mapper = VideoMapper.new(yt_token, gateway_class)
        end

        def build_entity
          CodePraise::Entity::Project.new(
            kind:,
            etag:,
            next_page_token:,
            region_code:,
            videos:
          )
        end

        def kind
          @data['kind']
        end

        def etag
          @data['etag']
        end

        def next_page_token
          @data['nextPageToken']
        end

        def region_code
          MemberMapper.build_entity(@data['regionCode'])
        end

        def videos
          @member_mapper.load_several(@data['items'])
        end
      end
    end
  end
end
