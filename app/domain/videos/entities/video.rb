# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TopPop
  # Provides access to video data
  module Entity
    class Video < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :video_id,        Strict::String
      attribute :title,           Strict::String
      attribute :publish_date,    Strict::String
      attribute :channel_title,   Strict::String
      attribute :view_count,      Strict::Bigint
      attribute :like_count,      Strict::Bigint
      attribute :comment_count,   Strict::Integer

      def to_attr_hash
        to_hash
      end
    end
  end
end
