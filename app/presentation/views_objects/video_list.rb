# frozen_string_literal: true

require_relative 'video'

module YoutubeInformation
  module Views
    # View for a list of video entities
    class VideoList
      def initialize(videos)
        @videos = videos.map { |video| Video.new(video) }
      end

      def any?
        @videos.any?
      end
    end
  end
end