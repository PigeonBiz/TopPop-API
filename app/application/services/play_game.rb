# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    # Start to play game
    class PlayGame
      include Dry::Transaction

      step :get_name
      step :played_today?
      step :play_game
      step :store_score
      step :show_score

      private

      def get_name(input)
        if input.success?
          
        else
          
        end
      end

      
    end
  end
end