# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeInformation
  # Provides access to video data
  module Entity
    class Video < Dry::Struct
      include Dry.Types

      attribute :id,              Strict::String
      attribute :title,           Strict::String
      attribute :publish_date,    Strict::String
      attribute :channel_title,   Strict::String
    end
  end
end
