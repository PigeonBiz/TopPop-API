#frozen_string_literal: false

require_relative '../../../helpers/spec_helper'
require_relative '../../../helpers/vcr_helper'
require_relative '../../../helpers/database_helper'

describe 'Integration tests of daily videos' do
  VcrHelper.setup_vcr

  before do
    VcrHelper.configure_vcr_for_youtube
  end

  after do
    VcrHelper.eject_vcr
  end

  describe 'Show 5 videos' do
    before do
      DatabaseHelper.wipe_database
    end

    it 'HAPPY: should be able to save 5 videos from Youtube to database' do
      # We haven't finish the game's features that use the services, so we cannot test the services now. 
    end
  end
end
