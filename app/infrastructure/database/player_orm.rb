# frozen_string_literal: true

require 'sequel'

module YoutubeInformation
  # Model for Database
  module Database
    # Object-Relational Mapper for Players
    class PlayerOrm < Sequel::Model(:players)
      plugin :timestamps, update_on_create: true
    end
  end
end
