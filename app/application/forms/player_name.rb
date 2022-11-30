# frozen_string_literal: true

require 'dry-validation'

module TopPop
  module Forms
    class PlayerName < Dry::Validation::Contract
      REGEX = %r{/.*/}.freeze
      # REGEX = %r{/^\w+\w$/}.freeze # invalid all the time

      params do
        required(:player_name).filled(:string)
      end

      rule(:player_name) do
        unless REGEX.match?(value)
          key.failure('Invalid player name')
        end
      end
    end
  end
end
