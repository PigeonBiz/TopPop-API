# frozen_string_literal: true

require 'dry-types'
require 'dry-struct'

module TopPop
  # Provides access to daily video data
  module Entity
    class DailyVideo < Dry::Struct
      include Dry.Types

      attribute :ranking,         Strict::Integer

      def to_attr_hash
        to_hash
      end

      def get_video_id
        "#{video_id}"
      end
    end
  end
end
