# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    # Start to play game
    class VerifyPlayer
      include Dry::Transaction

      step :verify_player

      private

      def verify_player(player_name)
        if player_name.success?
          Success(player_name)
        else
          Failure("#{player_name.errors.messages.first}")
        end
      end
    end
  end
end
