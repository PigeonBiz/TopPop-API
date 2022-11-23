# frozen_string_literal: true

require_relative 'spec_helper'
require_relative 'helpers/vcr_helper'

describe 'Tests Youtube API library' do # rubocop:disable Metrics/BlockLength
  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Tests Youtube API search request' do
    it 'HAPPY: should provide correct search informations' do
      yt_results = TopPop::Youtube::SearchMapper
                   .new(YOUTUBE_TOKEN)
                   .search(SEARCH_KEY_WORD, COUNT)

      _(yt_results.kind).must_equal CORRECT['kind']
      _(yt_results.etag).wont_be_nil
      _(yt_results.next_page_token).must_equal CORRECT['nextPageToken']
      _(yt_results.region_code).must_equal CORRECT['regionCode']
    end

    # it 'HAPPY: project should not have sensitive attributes' do
    #   _(@project.to_attr_hash.keys & %i[id owner contributors]).must_be_empty
    # end

    it 'SAD: should raise exception on incorrect search path' do
      _(proc do
        TopPop::Youtube::SearchMapper
          .new(YOUTUBE_TOKEN)
          .search('wrong path', COUNT)
      end).must_raise TopPop::Youtube::Api::Response::BadRequest
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        TopPop::Youtube::SearchMapper
          .new('BAD_TOKEN')
          .search(SEARCH_KEY_WORD, COUNT)
      end).must_raise TopPop::Youtube::Api::Response::BadRequest
    end
  end

  describe 'Tests Youtube API videos information' do
    describe 'Video information' do
      before do
        @video = TopPop::Youtube::SearchMapper
                 .new(YOUTUBE_TOKEN)
                 .search(SEARCH_KEY_WORD, COUNT)
      end

      it 'HAPPY: should identify videos information' do
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

        videos_view_count = videos.map(&:view_count)
        _(videos_view_count).wont_be_nil

        videos_like_count = videos.map(&:like_count)
        _(videos_like_count).wont_be_nil

        videos_comment_count = videos.map(&:comment_count)
        _(videos_comment_count).wont_be_nil
      end
    end
  end
end
