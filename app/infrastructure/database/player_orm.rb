# frozen_string_literal: true

require 'sequel'

module PlayerInformation
  # Model for Database
  module Database
    # Object-Relational Mapper for Players
    class PlayerOrm < Sequel::Model(:players)
      one_to_many :scores,
                  class: :'PlayerInformation::Database::ScoreOrm',
                  key: :player_id

      plugin :timestamps, update_on_create: true
    end
  end
end
