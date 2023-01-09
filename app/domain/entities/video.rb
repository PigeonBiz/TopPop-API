# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TopPop
  module Entity
    # Provides access to video data
    class Video < Dry::Struct
      include Dry.Types

      attribute :video_id,        Strict::String
      attribute :title,           Strict::String
      attribute :publish_date,    Strict::String
      attribute :channel_title,   Strict::String
      attribute :view_count,      Strict::Integer

      def to_attr_hash
        to_hash
      end

      def get_video_id
        video_id.to_s
      end
    end
  end
end
