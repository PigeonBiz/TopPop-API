# frozen_string_literal: true

ENV['RACK_ENV'] = 'test'

require 'simplecov'
SimpleCov.start

require 'yaml'

require 'minitest/autorun'
require 'minitest/rg'
require 'vcr'
require 'webmock'

require_relative '../require_app'
require_app

SEARCH_KEY_WORD = 'taylor%20swift%20offical'
COUNT = 5
CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
YOUTUBE_TOKEN = CONFIG['ACCESS_TOKEN']
CORRECT = YAML.safe_load(File.read('spec/fixtures/yt_results.yml'))

CASSETTES_FOLDER = 'spec/fixtures/cassettes'
CASSETTE_FILE = 'youtube_api'
