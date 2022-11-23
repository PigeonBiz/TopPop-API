# frozen_string_literal: true

# Helper to clean database during test runs
module DatabaseHelper
  def self.wipe_database
    # Ignore foreign key constraints when wiping tables
    TopPop::App.DB.run('PRAGMA foreign_keys = OFF')
    TopPop::Database::VideoOrm.map(&:destroy)
    TopPop::Database::PlayerOrm.map(&:destroy)
    TopPop::App.DB.run('PRAGMA foreign_keys = ON')
  end
end
