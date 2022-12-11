# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

require_relative 'video_representer'

module TopPop
  module Representer
    # Represents a CreditShare value
    class Videos < Roar::Decorator
      include Roar::JSON

      collection :videos, extend: Representer::Video, class: OpenStruct
    end
  end
end
