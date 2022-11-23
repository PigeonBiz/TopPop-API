# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TopPop
  # Provides access to video data
  module Entity
    class Score < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :player_name,     Strict::String
      attribute :score,           Strict::Integer

      def to_attr_hash
        to_hash
      end
    end
  end
end
