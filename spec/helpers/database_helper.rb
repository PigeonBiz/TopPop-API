# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    YoutubeInformation::App.DB.run('PRAGMA foreign_keys = OFF')
    YoutubeInformation::Database::VideoOrm.map(&:destroy)
    # YoutubeInformation::Database::PlayerOrm.map(&:destroy)
    YoutubeInformation::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
