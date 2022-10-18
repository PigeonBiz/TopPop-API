# frozen_string_literal: true

require 'http'
require 'yaml'

config = YAML.safe_load(File.read('../config/secrets.yml'))
SEARCH_KEY_WORD = 'taylor%20swift'
SEARCH_RESULT_NUM = '5'

def yt_api_path(search, config, result_num)
  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{search}&key=#{config['ACCESS_TOKEN']}&type=video&maxResults=#{result_num}"
end

def call_yt_url(url)
  HTTP.headers('Accept' => 'application/json').get(url)
end

yt_response = {}
yt_results = {}

## HAPPY project request
project_url = yt_api_path(SEARCH_KEY_WORD, config, SEARCH_RESULT_NUM)
yt_response[project_url] = call_yt_url(project_url)
project = yt_response[project_url].parse

yt_results['kind'] = project['kind']
yt_results['regionCode'] = project['regionCode']
yt_results['items'] = project['items']

# BAD project request
bad_project_url = yt_api_path(SEARCH_KEY_WORD, 'bad_token', SEARCH_RESULT_NUM)
yt_response[bad_project_url] = call_yt_url(bad_project_url)
yt_response[bad_project_url].parse

File.write('../spec/fixtures/yt_results.yml', yt_results.to_yaml)
