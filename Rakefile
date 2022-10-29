# frozen_string_literal: true

require 'rake/testtask'

task :default do
  puts `rake -T`
end

desc 'setup hidden files'
task :setup do
  mkdir 'config'
  sh 'touch config/secrets.yml'
  sh 'echo --- >> config/secrets.yml'
  sh 'echo   ACCESS_TOKEN: >> config/secrets.yml'
  sh 'nano config/secrets.yml'
end

desc 'run tests'
task :spec do
  sh 'ruby spec/yt_api_spec.rb'
end

desc 'Keep rerunning tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
end

task :run do
  sh 'bundle exec puma'
end

task :rerun do
  sh "rerun -c --ignore 'coverage/*' -- bundle exec puma"
end

desc 'search new for once'
task :searchnew do
  sh 'ruby spec/fixtures/search_info.rb'
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
  only_app = 'config/ app/'

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
    sh "flog -m #{only_app}"
  end
end
