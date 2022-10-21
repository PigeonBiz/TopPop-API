# frozen_string_literal: true

require_relative 'video'

module YoutubeInformation
  # Model for Information
  class Information
    def initialize(information_data, data_source)
      @information = information_data
      @data_source = data_source
    end

    def kind
      @information['kind']
    end

    def etag
      @information['etag']
    end

    def next_page_token
      @information['nextPageToken']
    end

    def region_code
      @information['regionCode']
    end

    def videos
      @videos ||= @data_source.videos(@information['items'])
    end
  end
end
