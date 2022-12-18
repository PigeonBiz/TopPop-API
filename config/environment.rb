# frozen_string_literal: true

require 'roda'
require 'figaro'
require 'logger'
require 'rack/session'
require 'rack/cache'
require 'redis-rack-cache'

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
    
     # Setup Cacheing mechanism
     configure :development do
      use Rack::Cache,
          verbose: true,
          metastore: 'file:_cache/rack/meta',
          entitystore: 'file:_cache/rack/body'
    end

    configure :production do
      use Rack::Cache,
          verbose: true,
          metastore: "#{config.REDISCLOUD_URL}/0/metastore",
          entitystore: "#{config.REDISCLOUD_URL}/0/entitystore"
    end
  end
end
