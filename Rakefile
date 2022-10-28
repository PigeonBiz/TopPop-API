# frozen_string_literal: true

require 'rake/testtask'

CODE = 'lib/'

task :default do
  puts `rake -T`
end

desc 'setup hidden files'
task :setup do
  mkdir 'config'
  sh 'touch config/secrets.yml'
end

desc 'run tests'
task :spec do
  sh 'ruby spec/fixtures/search_info.rb'
  sh 'ruby spec/yt_api_spec.rb'
end

namespace :vcr do
  desc 'delete cassette fixtures'
  task :wipe do
    sh 'rm spec/fixtures/cassettes/*.yml' do |ok, _|
      puts(ok ? 'Cassettes deleted' : 'No cassettes found')
    end
  end
end

namespace :quality do
  desc 'run all static-analysis quality checks'
  task all: %i[rubocop flog reek]

  desc 'code style linter'
  task :rubocop do
    sh 'rubocop'
  end

  desc 'code smell detector'
  task :reek do
    sh 'reek'
  end

  desc 'complexiy analysis'
  task :flog do
    sh "flog #{CODE}"
  end
end
