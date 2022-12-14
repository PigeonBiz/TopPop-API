# frozen_string_literal: true

require 'rake/testtask'
require_relative 'require_app'

task :default do
  puts `rake -T`
end

desc 'Run unit and integration tests'
Rake::TestTask.new(:spec) do |t|
  t.pattern = 'spec/tests/{integration,unit}/**/*_spec.rb'
  t.warning = false
end

desc 'Keep rerunning unit/integration tests upon changes'
task :respec do
  sh "rerun -c 'rake spec' --ignore 'coverage/*'"
end

desc 'Run the webserver and application and restart if code changes'
task :rerun do
  sh "rerun -c --ignore 'coverage/*' -- bundle exec puma"
end

namespace :run do
  desc 'Run API in dev mode'
  task :dev do
    sh 'rerun -c "bundle exec puma -p 9009"'
  end

  desc 'Run API in test mode'
  task :test do
    sh 'rerun -c "bundle exec puma -p 9009"'
  end
end

namespace :run do
  task :dev do
    sh "rerun -c --ignore 'coverage/*' -- bundle exec puma -p 9000"
  end

  task :test do
    sh "rerun -c --ignore 'coverage/*' -- bundle exec puma -p 9000"
  end
end

desc 'Run application console'
task :console do
  sh 'pry -r ./load_all'
end

namespace :quality do
  only_app = 'config/ app/'

  desc 'run all static-analysis quality checks'
  task all: %i[rubocop reek flog]

  desc 'code style linter'
  task :rubocop do
    sh 'rubocop'
  end

  desc 'code smell detector'
  task :reek do
    sh "reek #{only_app}"
  end

  desc 'complexiy analysis'
  task :flog do
    sh "flog -m #{only_app}"
  end
end
