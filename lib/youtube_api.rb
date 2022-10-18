# frozen_string_literal: true

require 'http'
require_relative 'information'

module CodePraise
  # Library for Facebook Web API
  class FacebookApi
    API_INFROMATION_ROOT = 'https://graph.facebook.com/v15.0'

    module Errors
      class BadRequest < StandardError; end
    end

    HTTP_ERROR = {
      400 => Errors::BadRequest
    }.freeze

    def initialize(token)
      @fb_token = token
    end

    def information(path)
      information_req_url = fb_api_path(path)
      information_data = call_fb_url(information_req_url).parse
      Information.new(information_data, self)
    end

    private

    def fb_api_path(path)
      "#{API_INFROMATION_ROOT}/#{path}&access_token=#{@fb_token}"
    end

    def call_fb_url(url)
      result = HTTP.headers('Accept' => 'application/json').get(url)
      successful?(result) ? result : raise(HTTP_ERROR[result.code])
    end

    def successful?(result)
      !HTTP_ERROR.keys.include?(result.code)
    end
  end
end
