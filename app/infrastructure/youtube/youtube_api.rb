# frozen_string_literal: true

require 'http'

module TopPop
  module Youtube
    # Library for Youtube Web API
    class Api
      def initialize(token)
        @yt_token = token
      end

      def search_data(search, count)
        Request.new(@yt_token).search_video(search, count).parse
      end

      def video_data(video_id)
        Request.new(@yt_token).get_video_info(video_id).parse
      end

      # Sends out HTTP requests to Youtube
      class Request
        API_SEARCH_ROOT = 'https://www.googleapis.com/youtube/v3'

        def initialize(token)
          @yt_token = token
        end

        def yt_search_api_path(search, count)
          "#{API_SEARCH_ROOT}/search?part=snippet&q=#{search}&key=#{@yt_token}&type=video&maxResults=#{count}"
        end

        def yt_video_api_path(video_id)
          "#{API_SEARCH_ROOT}/videos?part=statistics,snippet&id=#{video_id}&key=#{@yt_token}"
        end

        def search_video(search, count)
          get(yt_search_api_path(search, count))
        end

        def get_video_info(video_id)
          get(yt_video_api_path(video_id))
        end

        def get(url)
          result = HTTP.headers('Accept' => 'application/json').get(url)

          Response.new(result).tap do |response|
            raise(response.error) unless response.successful?
          end
        end
      end

      # Decorates HTTP responses from Youtube with success/error
      class Response < SimpleDelegator
        BadRequest = Class.new(StandardError)

        HTTP_ERROR = {
          400 => BadRequest
        }.freeze

        def successful?
          !HTTP_ERROR.keys.include?(code)
        end

        def error
          HTTP_ERROR[code]
        end
      end
    end
  end
end
