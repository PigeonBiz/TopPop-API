# frozen_string_literal: true

module TopPop
  module Game
    # gameplay needed tools
    class GameStarter
      def initialize(player_name)
        @player_name = player_name
      end

      def check_played_today(player_name)
        played_today?(player_name)
      end

      def played_today?(player_name)
        PlayerInformation::Repository::Scores.find(player_name)
      end
    end
  end
end
