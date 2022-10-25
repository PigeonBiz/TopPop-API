# frozen_string_literal: true

require_relative 'spec_helper'

describe 'Tests Youtube API library' do # rubocop:disable Metrics/BlockLength
  VCR.configure do |c|
    c.cassette_library_dir = CASSETTES_FOLDER
    c.hook_into :webmock

    c.filter_sensitive_data('<YOUTUBE_TOKEN>') { YOUTUBE_TOKEN }
    c.filter_sensitive_data('<YOUTUBE_TOKEN_ESC>') { CGI.escape(YOUTUBE_TOKEN) }
  end

  before do
    VCR.insert_cassette CASSETTE_FILE,
                        record: :new_episodes,
                        match_requests_on: %i[method uri headers]
  end

  after do
    VCR.eject_cassette
  end

  describe 'Tests Youtube API search request' do
    describe 'Search information' do
      it 'HAPPY: should provide correct search informations' do
        yt_results = YoutubeInformation::Youtube::SearchMapper.new(YOUTUBE_TOKEN).search(SEARCH_KEY_WORD, COUNT)
        _(yt_results.kind).must_equal CORRECT['kind']
        _(yt_results.etag).wont_be_nil
        _(yt_results.next_page_token).must_equal CORRECT['nextPageToken']
        _(yt_results.region_code).must_equal CORRECT['regionCode']
      end

      it 'SAD: should raise exception on incorrect search path' do
        _(proc do
          YoutubeInformation::Youtube::SearchMapper.new(YOUTUBE_TOKEN).search('wrong path', COUNT)
        end).must_raise YoutubeInformation::Youtube::Api::Response::BadRequest
      end

      it 'SAD: should raise exception when unauthorized' do
        _(proc do
          YoutubeInformation::Youtube::SearchMapper.new('BAD_TOKEN').search(SEARCH_KEY_WORD, COUNT)
        end).must_raise YoutubeInformation::Youtube::Api::Response::BadRequest
      end
    end
  end

  describe 'Tests Youtube API videos information' do
    describe 'Video information' do
      before do
        @video = YoutubeInformation::Youtube::SearchMapper.new(YOUTUBE_TOKEN).search(SEARCH_KEY_WORD, COUNT)
      end

      it 'HAPPY: should identify videos ID' do
        videos = @video.videos
        _(videos.count).must_equal CORRECT['items'].count

        videos_id = videos.map(&:video_id)
        _(videos_id).wont_be_nil

        videos_channel_title = videos.map(&:channel_title)
        _(videos_channel_title).wont_be_nil

        videos_title = videos.map(&:title)
        _(videos_title).wont_be_nil

        videos_publish_date = videos.map(&:publish_date)
        _(videos_publish_date).wont_be_nil
      end
    end
  end
end
