# frozen_string_literal: true

module TopPop
  module Game
    # gameplay needed tools
    class DailyVideos
      def daily_videos
        TopPop::Repository::Videos.all
      end
    end
  end
end
