# frozen_string_literal: true

require 'http'
require 'yaml'

config = YAML.safe_load(File.read('../config/secrets.yml'))
SEARCH_KEY_WORD = 'taylor%20swift%20offical'
SEARCH_RESULT_NUM = 5

def yt_api_path(search, config, result_num)
  "https://www.googleapis.com/youtube/v3/search?part=snippet&q=#{search}&key=#{config['ACCESS_TOKEN']}&type=video&maxResults=#{result_num}"
end

def call_yt_url(url)
  HTTP.headers('Accept' => 'application/json').get(url)
end

yt_response = {}
yt_results = {}

## HAPPY search request
search_url = yt_api_path(SEARCH_KEY_WORD, config, SEARCH_RESULT_NUM)
yt_response[search_url] = call_yt_url(search_url)
search_result = yt_response[search_url].parse

yt_results['kind'] = search_result['kind']
yt_results['etag'] = search_result['etag']
yt_results['nextPageToken'] = search_result['nextPageToken']
yt_results['regionCode'] = search_result['regionCode']
yt_results['items'] = search_result['items']

# BAD search request
bad_search_url = yt_api_path(SEARCH_KEY_WORD, 'bad_token', SEARCH_RESULT_NUM)
yt_response[bad_search_url] = call_yt_url(bad_search_url)
yt_response[bad_search_url].parse

File.write('../spec/fixtures/yt_results.yml', yt_results.to_yaml)
