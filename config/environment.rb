# frozen_string_literal: true

require 'roda'
require 'figaro'
require 'sequel'
require 'logger'
require 'rack/session'

module TopPop
  # Configuration for the App
  class App < Roda
    plugin :environments

    configure do
      # Environment variables setup
      Figaro.application = Figaro::Application.new(
        environment:,
        path: File.expand_path('config/secrets.yml')
      )
      Figaro.load
      def self.config = Figaro.env

      use Rack::Session::Cookie, secret: config.SESSION_SECRET

      configure :development, :test do
        ENV['DATABASE_URL'] = "sqlite://#{config.DB_FILENAME}"
      end

      # Database Setup
      DB = Sequel.connect(ENV.fetch('DATABASE_URL'))
      def self.DB = DB

      # Logger Setup
      LOGGER = Logger.new($stderr)
      def self.logger = LOGGER      
    end
  end
end
