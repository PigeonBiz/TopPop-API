# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    # verify player name
    class VerifyPlayer
      include Dry::Transaction

      step :verify_player

      private

      def verify_player(player_name)
        if player_name.success?
          Success(player_name)
        else
          Failure(player_name.errors.messages.first.to_s)
        end
      end
    end
  end
end
