# frozen_string_literal: true

require 'sequel'

module TopPop
  # Model for Database
  module Database
    # Object-Relational Mapper for Videos
    class VideoOrm < Sequel::Model(:videos)
      plugin :timestamps, update_on_create: true
    end
  end
end
