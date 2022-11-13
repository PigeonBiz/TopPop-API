# frozen_string_literal: true

require 'sequel'

module ScoreInformation
  # Model for Database
  module Database
    # Object-Relational Mapper for Scores
    class ScoreOrm < Sequel::Model(:scores)
      plugin :timestamps, update_on_create: true
    end
  end
end
