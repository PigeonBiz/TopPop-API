# frozen_string_literal: true

module PlayerInformation
  # Provides access to score data
  module Player
    # Data Mapper: Player search -> Score entity
    class VideoMapper
      def initialize(yt_token, scores_data, gateway_class = Player::Api)
        @yt_token = yt_token
        @scores_data = scores_data
        @gateway_class = gateway_class
        @gateway = @gateway_class.new(@yt_token)
      end

      def build2vid
        @scores_data.map do |score_data|
          score_information = @gateway.score_data(score_data['id']['scoreId'])
          VideoMapper.build_entity(score_information['items'][0])
        end
      end

      def self.build_entity(score_data)
        DataMapper.new(score_data).build_entity
      end

      # Extracts entity specific elements from data structure
      class DataMapper
        def initialize(score_data)
          @score_data = score_data
        end

        def build_entity
          Entity::Score.new(
            score_id:,
            title:,
            publish_date:,
            channel_title:,
            view_count:,
            like_count:,
            comment_count:
          )
        end

        private

        def score_id
          @score_data['id']
        end

        def title
          @score_data['snippet']['title']
        end

        def publish_date
          @score_data['snippet']['publishedAt']
        end

        def channel_title
          @score_data['snippet']['channelTitle']
        end

        def view_count
          @score_data['statistics']['viewCount'].to_i
        end

        def like_count
          @score_data['statistics']['likeCount'].to_i
        end

        def comment_count
          @score_data['statistics']['commentCount'].to_i
        end
      end
    end
  end
end
