# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

require_relative 'score'

module PlayerInformation
  # Model for Information
  module Entity
    class Player < Dry::Struct
      include Dry.Types

      attribute :id,              Integer.optional
      attribute :name,            Strict::String
      attribute :scores,          Strict::Array.of(Score)

      def to_attr_hash
        to_hash
      end
    end
  end
end
