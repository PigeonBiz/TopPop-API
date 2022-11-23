# frozen_string_literal: true

module TopPop
  # Provides access to score data
  module Player
    # Data Mapper: Player search -> Score entity
    class ScoreMapper
      def initialize(score, player_name, gateway_class = Player::Api)
        @scores_data['score'] = score
        @scores_data['player_name'] = player_name
        @gateway_class = gateway_class
      end

      def build2id
        ScoreMapper.build_entity(@scores_data)
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
            player_name:,
            score:
          )
        end

        private

        def player_name
          @score_data['player_name']
        end

        def score
          @score_data['score'].to_i
        end
      end
    end
  end
end
