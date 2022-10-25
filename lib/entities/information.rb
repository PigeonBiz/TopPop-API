# frozen_string_literal: true

require 'dry-struct'
require 'dry-types'

require_relative 'video'

module YoutubeInformation
  # Model for Information
  module Entity
    class Information < Dry::Struct
      include Dry.Types

      attribute :kind,          Strict::String
      attribute :etag,          Strict::String
      attribute :nextPageToken, Strict::String
      attribute :regionCode,    Strict::String
      attribute :videos,        Strict::Array.of(Video)
    end
  end
end
