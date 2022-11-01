# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeInformation
  # Provides access to video data
  module Entity
    class Video < Dry::Struct
      include Dry.Types

      attribute :video_id,        Strict::String
      attribute :title,           Strict::String
      attribute :publish_date,    Strict::String
      attribute :channel_title,   Strict::String
      attribute :view_count,      Strict::Integer
      attribute :like_count,      Strict::Integer
      attribute :comment_count,   Strict::Integer
    end
  end
end
