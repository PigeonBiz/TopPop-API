# frozen_string_literal: true

require 'sequel'

module PlayerInformation
  # Model for Database
  module Database
    # Object-Relational Mapper for Scores
    class ScoreOrm < Sequel::Model(:scores)
      many_to_one :player,
                  class: :'PlayerInformation::Database::PlayerOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
