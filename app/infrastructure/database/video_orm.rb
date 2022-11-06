# frozen_string_literal: true

require 'sequel'

module YoutubeInformation
  # Model for Database
  module Database
    # Object-Relational Mapper for Videos
    class VideoOrm < Sequel::Model(:videos)
      plugin :timestamps, update_on_create: true
    end

    # def self.find_or_create(player_info)
    #   first(name: player_info[:name]) || create(player_info)
    # end
  end
end
