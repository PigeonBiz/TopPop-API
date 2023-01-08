# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'video'

module TopPop
  # Model for Information
  module Entity
    class Information < Dry::Struct
      include Dry.Types

      attribute :kind,            Strict::String
      attribute :etag,            Strict::String
      attribute :next_page_token, Strict::String
      attribute :region_code,     Strict::String
      attribute :videos,          Strict::Array.of(Video)
    end
  end
end
