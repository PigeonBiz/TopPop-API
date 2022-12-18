# frozen_string_literal: true

require 'sequel'

module TopPop
  # Model for Database
  module Database
    # Object-Relational Mapper for DailyVideos
    class DailyVideoOrm < Sequel::Model(:daily_videos)
      one_to_one  :original_video,
                  class: :'TopPop::Database::VideoOrm'

      plugin :timestamps, update_on_create: true
    end
  end
end
