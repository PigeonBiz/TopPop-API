# frozen_string_literal: true

module PlayerInformation
  # Provides access to score data
  module Player
    # Data Mapper: Player search -> Score entity
    class ScoreMapper
      def initialize(score, player_id)
        @scores_data['score'] = score
        @scores_data['player_id'] = player_id
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
            player_id:,
            score:
          )
        end

        private

        def player_id
          @score_data['player_id']
        end

        def score
          @score_data['score'].to_i
        end
      end
    end
  end
end
