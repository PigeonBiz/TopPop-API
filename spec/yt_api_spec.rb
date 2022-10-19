# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/youtube_api'

SEARCH_KEY_WORD = 'taylor%20swift%20offical'
COUNT = 5
CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
YOUTUBE_TOKEN = CONFIG['ACCESS_TOKEN']
CORRECT = YAML.safe_load(File.read('fixtures/yt_results.yml'))

describe 'Tests Youtube API search request' do
  describe 'Search information' do
    it 'HAPPY: should provide correct search informations' do
      yt_results = CodePraise::YoutubeApi.new(YOUTUBE_TOKEN).information(SEARCH_KEY_WORD, COUNT)
      puts yt_results
      _(yt_results.kind).must_equal CORRECT['kind']
      _(yt_results.next_page_token).must_equal CORRECT['nextPageToken']
      _(yt_results.region_code).must_equal CORRECT['regionCode']
    end

    it 'SAD: should raise exception on incorrect search path' do
      _(proc do
        CodePraise::YoutubeApi.new(YOUTUBE_TOKEN).information('wrong path', COUNT)
      end).must_raise CodePraise::YoutubeApi::Errors::BadRequest
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        CodePraise::YoutubeApi.new('BAD_TOKEN').information(SEARCH_KEY_WORD, COUNT)
      end).must_raise CodePraise::YoutubeApi::Errors::BadRequest
    end
  end
end

describe 'Tests Youtube API videos information' do
  describe 'Video information' do
    before do
      @video = CodePraise::YoutubeApi.new(YOUTUBE_TOKEN).information(SEARCH_KEY_WORD, COUNT)
    end

    it 'HAPPY: should identify videos ID' do
      videos = @video.videos
      _(videos.count).must_equal CORRECT['items'].count

      videos_id = videos.map(&:video_id)
      correct_videos = CORRECT['items'].map { |v| v['id']['videoId'] }
      _(videos_id).must_equal correct_videos
    end
  end
end
