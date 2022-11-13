# frozen_string_literal: true

require_relative 'score_mapper'

module PlayerInformation
  module Player
    class SearchMapper
      def initialize(yt_token, gateway_class = Player::Api)
        @yt_token = yt_token
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      def search(keyword, count)
        data = @gateway.search_data(keyword, count)
        build_entity(data)
      end

      def build_entity(data)
        DataMapper.new(data, @yt_token).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(data, yt_token)
          @data = data
          @yt_token = yt_token
        end

        def build_entity
          Entity::Information.new(
            kind:,
            etag:,
            next_page_token:,
            region_code:,
            scores:
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
          @data['regionCode']
        end

        def scores
          VideoMapper.new(@yt_token, @data['items']).build2vid
        end
      end
    end
  end
end
