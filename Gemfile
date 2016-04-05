source 'https://rubygems.org'
ruby ENV['RUBY_VERSION'] if ENV['RUBY_VERSION']

group :development, :test do
  gem 'dotenv-rails' # load before other gems
end

gem 'rails', '~> 4.2.1'
gem 'sprockets', '~> 2.7' # so test files can be .jsx
gem 'jbuilder'
gem 'will_paginate'
gem 'pg'

gem 'react-rails'
gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes

gem 'devise' # handle authenticaton, register , forgot password, etc
gem 'intercom-rails' # monitor shoppers

gem 'rollbar' # for error collecting
gem 'newrelic_rpm' # app peformance tracking

gem 'faraday', require: false # for making http request
gem 'carmen', require: false # for country and region information
gem 'json', require: false

gem 'component_library'

group :development do
  gem 'annotate', '~> 2.6', require: false
end

group :development, :test do
  # gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring', require: false # Spring speeds up development by keeping your application running in the background
  gem 'spring-commands-testunit', require: false
  gem 'jasmine-rails'
end

group :test do
  gem 'webmock', require: false
  gem 'capybara', require: false
  gem 'capybara-email', require: false
  gem 'poltergeist', require: false
  gem 'shoulda-context'
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
end
