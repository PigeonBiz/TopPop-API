# frozen_string_literal: true

require 'http'

module YoutubeInformation
  # Library for Youtube Web API
  class YoutubeApi
    API_INFROMATION_ROOT = 'https://www.googleapis.com/youtube/v3'

    module Errors
      # Generates Error
      class BadRequest < StandardError; end
    end

    HTTP_ERROR = {
      400 => Errors::BadRequest
    }.freeze

    def initialize(token)
      @yt_token = token
    end

    def information(search, count)
      information_req_url = yt_api_path(search, count)
      information_data = call_yt_url(information_req_url).parse
      Information.new(information_data, self)
    end

    def videos(videos_data)
      videos_data.map { |video_data| Video.new(video_data) }
    end

    def yt_api_path(search, count)
      "#{API_INFROMATION_ROOT}/search?part=snippet&q=#{search}&key=#{@yt_token}&type=video&maxResults=#{count}"
    end

    def call_yt_url(url)
      result = HTTP.headers('Accept' => 'application/json').get(url)
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
