# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module YoutubeInformation
  # Provides access to video data
  module Entity
    class Score < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :player_id,       Strict::Integer
      attribute :score,           Strict::Integer

      def to_attr_hash
        to_hash
      end
    end
  end
end
