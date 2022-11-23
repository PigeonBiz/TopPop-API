#frozen_string_literal: false

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'
require_relative 'helpers/database_helper'

describe 'Integration Tests of Youtube API and Database' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Retrieve and store video' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save video from Youtube to database' do
       youtube_search = TopPop::Youtube::SearchMapper
         .new(YOUTUBE_TOKEN)
         .search(SEARCH_KEY_WORD, COUNT)
       rebuilt = youtube_search.videos.map {|video|  TopPop::Repository::Videos.create(video)}
       videos = youtube_search.videos.first
       _(rebuilt.first.video_id).must_equal(videos.video_id)
       _(rebuilt.first.channel_title).must_equal(videos.channel_title)
       _(rebuilt.first.title).must_equal(videos.title)
       _(rebuilt.first.publish_date).must_equal(videos.publish_date)
       _(rebuilt.first.view_count).must_equal(videos.view_count)
       _(rebuilt.first.like_count).must_equal(videos.like_count)
       _(rebuilt.first.comment_count).must_equal(videos.comment_count)

       end
  end
end
