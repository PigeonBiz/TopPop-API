# frozen_string_literal: true

source 'https://rubygems.org'
ruby File.read('.ruby-version').strip

# CONFIGURATION
gem 'figaro', '~> 1.2'
gem 'rack-test' # for testing and can also be used to diagnose in production
gem 'rake', '~> 13.0'

# PRESENTATION LAYER
gem 'slim', '~> 4.1'

# APPLICATION LAYER
# Web application related
gem 'multi_json', '~> 1.15'
gem 'puma', '~> 6.0'
gem 'rack-session', '~> 0.3'
gem 'roar', '~> 1.1'
gem 'roda', '~> 3.62'
gem 'tilt', '~> 2.0'

# Controllers and services
gem 'dry-monads', '~> 1.4'
gem 'dry-transaction', '~> 0.13'
gem 'dry-validation', '~> 1.7'

# Caching
gem 'rack-cache', '~> 1.13'
gem 'redis', '~> 4.8'
gem 'redis-rack-cache', '~> 2.2'

# DOMAIN LAYER
# Validation
gem 'dry-struct', '~> 1'
gem 'dry-types', '~> 1'

# INFRASTRUCTURE LAYER
# Networking
gem 'http', '~> 5'

# TESTING
group :test do
  gem 'minitest', '~> 5'
  gem 'minitest-rg', '~> 5'
  gem 'simplecov', '~> 0'

  gem 'headless', '~> 2.3'
  gem 'page-object', '~> 2.3'
  gem 'watir', '~> 7.0'
  gem 'webdrivers', '~> 5.0'
end

group :development, :test do
  gem 'wdm', '>= 0.1.0'
end

# DEBUGGING
gem 'pry'

# QUALITY
group :development do
  gem 'rerun', '~> 0'
  gem 'flog'
  gem 'reek'
  gem 'rubocop'
end
