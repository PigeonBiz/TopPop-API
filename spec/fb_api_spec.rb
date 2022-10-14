# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/facebook_api'

PATH = 'me?fields=name%2Cbirthday%2Cemail%2Cfriends'
CONFIG = YAML.safe_load(File.read('../config/secrets.yml'))
FACEBOOK_TOKEN = CONFIG['ACCESS_TOKEN']
CORRECT = YAML.safe_load(File.read('fixtures/fb_results.yml'))

describe 'Tests Facebook API library' do
  describe 'User information' do
    it 'HAPPY: should provide correct user informations' do
      project = CodePraise::FacebookApi.new(FACEBOOK_TOKEN).information(PATH)
      _(project.name).must_equal CORRECT['name']
      _(project.email).must_equal CORRECT['email']
    end

    it 'SAD: should raise exception on incorrect project' do
      _(proc do
        CodePraise::FacebookApi.new(FACEBOOK_TOKEN).information('wrong_path')
      end).must_raise CodePraise::FacebookApi::Errors::BadRequest
    end

    it 'SAD: should raise exception when unauthorized' do
      _(proc do
        CodePraise::FacebookApi.new('BAD_TOKEN').information(PATH)
      end).must_raise CodePraise::FacebookApi::Errors::BadRequest
    end
  end
end