# frozen_string_literal: true

require 'dry-validation'

module TopPop
  module Forms
    class SearchKeyword < Dry::Validation::Contract
      REGEX = %r{[^<>]}.freeze 

      params do
        required(:search_keyword).filled(:string)
      end

      rule(:search_keyword) do
        unless REGEX.match?(value)
          key.failure('Search keyword is not valid! Please try a different keyword!')
        end
      end
    end
  end
end
