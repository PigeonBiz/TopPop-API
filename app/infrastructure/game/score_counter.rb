# frozen_string_literal: true

module TopPop
  module Game
    # gameplay needed tools
    class ScoreCounter
      def initialize(ranking)
        @ranking = ranking
      end

      def check_score(ranking)
        answer = ranking_answer
        score = 0
        score += 1 if answer[0] == ranking[0]
        score += 1 if answer[1] == ranking[1]
        score += 1 if answer[2] == ranking[2]
        score += 1 if answer[3] == ranking[3]
        score += 1 if answer[4] == ranking[4]
        score
      end

      def ranking_answer
        YoutubeInformation::Repository::Videos.ranking
      end
    end
  end
end
