# frozen_string_literal: true

require 'dry/transaction'

module TopPop
  module Service
    # Start to play game
    class PlayGame
      include Dry::Transaction

      step :verify_input
      step :get_last_play_date
      step :play_today?
      step :get_daily_videos

      private

      def verify_input(player_name)
        if player_name.success?
          Success(player_name)
        else
          Failure("#{player_name.errors.messages.first}")
        end
      end

      def get_last_play_date(player_name)
        db_player_data = Repository::For.klass(Entity.score)
                                        .find_player_last_playdate(player_name)
        Success(db_player_data)
      rescue StandardError => error
        App.logger.error error.backtrace.join("\n")
        Failure('Having trouble accessing the database for player data')
      end

      def play_today?(db_player_data)
        unless db_player_data[:created_at].today?
          Success(db_player_data)
        end
        Failure('You have played today. Come back tomorrow')
      end

      def get_daily_videos(db_player_data)
        daily_videos = Repository::For.klass(Entity::DailyVideo).daily_video_all
        Success(daily_videos)
      rescue StandardError => error
        App.logger.error error.backtrace.join("\n")
        Failure('Having trouble accessing the database for daily videos')
      end
    end
  end
end
