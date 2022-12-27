# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'daily_video_representer'

module TopPop
  module Representer
    # Represents a CreditShare value
    class DailyVideos < Roar::Decorator
      include Roar::JSON

      collection :daily_videos, extend: Representer::DailyVideos, class: OpenStruct
    end
  end
end
