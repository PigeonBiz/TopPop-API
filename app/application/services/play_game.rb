# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    # Start to play game
    class PlayGame
      include Dry::Transaction

      step :get_last_play_date
      step :play_today?
      step :play_game

      private

      def get_last_play_date(input)
        if input.success?
          play_data = Repository::For.klass(Entity.score).find_player_last_playdate(input)
          Success(play_data)
        else
          Failure("URL #{input.errors.messages.first}")
        end
      end

      def play_today?(input)
        if input[:created_at].today?
          Failure('Have played today')
        else
          Success('Not play yet today')
        end
      end

      def play_game(input)
        if input.success?
          today_videos = Repository::For.klass(Entity.video).daily_video_all
          Success(today_videos)
        else
          Failure("URL #{input.errors.messages.first}")
        end
      end
    end
  end
end
