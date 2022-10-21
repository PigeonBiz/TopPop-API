# frozen_string_literal: true

module YoutubeInformation
  # Provides access to video data
  class Video
    def initialize(video_data)
      @video = video_data
    end

    def video_id
      @video['id']['videoId']
    end

    def title
      @video['snippet']['title']
    end

    def publish_date
      @video['snippet']['publishedAt']
    end

    def channel_title
      @video['channelTitle']
    end
  end
end
