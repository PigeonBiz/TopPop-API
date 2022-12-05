# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module TopPop
  module Representer
    # Represents a CreditShare value
    class Video < Roar::Decorator
      include Roar::JSON

      property :video_id
      property :title
      property :publish_date
      property :channel_title
      property :view_count

      property :to_attr_hash
      property :get_video_id
    end
  end
end
