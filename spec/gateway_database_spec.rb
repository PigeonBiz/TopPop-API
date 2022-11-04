# frozen_string_literal: false

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

    # it 'HAPPY: should be able to save video from Youtube to database' do
    #   video = YoutubeInformation::Youtube::SearchMapper
    #     .new(YOUTUBE_TOKEN)
    #     .search(SEARCH_KEY_WORD, COUNT)
    #
    #   rebuilt = YoutubeInformation::Repository::For.entity(video).create(video)
    #
    #   videos = @video.videos # array?
    #   _(rebuilt.videos_id).must_equal(videos.videos_id)
    #   _(rebuilt.channel_title).must_equal(videos.channel_title)
    #   _(rebuilt.videos_title).must_equal(videos.videos_title)
    #   _(rebuilt.videos_publish_date).must_equal(videos.videos_publish_date)
    #   _(rebuilt.view_count).must_equal(videos.view_count)
    #   _(rebuilt.like_count).must_equal(videos.like_count)
    #   _(rebuilt.comment_count).must_equal(videos.comment_count)
    #
    #   # delete?
    #   videos.contributors.each do |member|
    #     found = rebuilt.contributors.find do |potential|
    #       potential.videos_id == member.videos_id
    #     end
    #
    #     _(found.username).must_equal member.username
    #     # not checking email as it is not always provided
    #   end
    # end
  end
end
