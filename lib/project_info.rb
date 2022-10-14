# frozen_string_literal: true

require 'http'
require 'yaml'

config = YAML.safe_load(File.read('../config/secrets.yml'))

def fb_api_path(path, config)
  "https://graph.facebook.com/v15.0/#{path}&access_token=#{config['ACCESS_TOKEN']}"
end

def call_fb_url(url)
  HTTP.headers('Accept' => 'application/json').get(url)
end

fb_response = {}
fb_results = {}

## HAPPY project request
project_url = fb_api_path('me?fields=name%2Cbirthday%2Cemail%2Cfriends', config)
fb_response[project_url] = call_fb_url(project_url)
project = fb_response[project_url].parse

fb_results['name'] = project['name']
fb_results['birthday'] = project['birthday']
fb_results['email'] = project['email']
fb_results['friends_total_count'] = project['friends']['summary']['total_count']

# BAD project request
bad_project_url = fb_api_path('soumya.ray.prof?fields=id%2Cname%2Cbirthday%2Cemail%2Cfriends', config)
fb_response[bad_project_url] = call_fb_url(bad_project_url)
fb_response[bad_project_url].parse

File.write('../spec/fixtures/fb_results.yml', fb_results.to_yaml)
