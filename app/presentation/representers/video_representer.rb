# frozen_string_literal: true

require 'roar/decorator'
require 'roar/json'

module TopPop
  module Representer
    # Represents a CreditShare value
    class Video < Roar::Decorator
      include Roar::JSON
      include Roar::Hypermedia
      include Roar::Decorator::HypermediaConsumer

      property :video_id
      property :title
      property :publish_date
      property :channel_title
      property :view_count

      link :self do
        "#{App.config.API_HOST}/api/v1/videos/#{video_id}"
      end

      private

      def video_id
        represented.video_id
      end
    end
  end
end
