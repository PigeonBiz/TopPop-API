# frozen_string_literal: true

require 'roda'
require 'figaro'
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
      
      # Logger Setup
      LOGGER = Logger.new($stderr)
      def self.logger = LOGGER      
    end
  end
end
