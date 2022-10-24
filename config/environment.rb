# frozen_string_literal: true

require 'roda'
require 'yaml'

module YoutubeInformation
  # Configuration for the App
  class App < Roda
    CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
    YOUTUBE_TOKEN = CONFIG['ACCESS_TOKEN']
  end
end