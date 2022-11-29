# frozen_string_literal: true

require 'dry/monads'

module TopPop
  module Service
    # Search history score
    class CountScore
      include Dry::Monads::Result::Mixin

      def call(answer)
        score = Game::ScoreCounter.check_score(answer)

        Success(score)
      rescue StandardError
        Failure(error.to_s)
      end
    end
  end
end
