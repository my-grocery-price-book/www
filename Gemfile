source 'https://rubygems.org'

group :development, :test do
  gem 'dotenv-rails' # load before other gems
end

gem 'rails', '~> 4.2.1'
gem 'comfortable_mexican_sofa', '~> 1.12'
gem 'will_paginate'
gem 'pg'

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes
gem 'opal-rails', '0.8.0'

gem 'devise' # handle authenticaton, register , forgot password, etc

gem 'puma', require: false

gem 'rollbar' # for error collecting
gem 'newrelic_rpm' # app peformance tracking
gem 'syslogger', require: false # log to syslog

gem 'faraday'

group :development do
  gem 'annotate', '~> 2.6', require: false
end

group :development, :test do
  # gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'sqlite3', require: false
  gem 'spring', require: false # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-commands-testunit', require: false
  gem 'factory_girl_rails'
end

group :test do
  gem 'webmock', require: false
  gem 'capybara'
  gem 'shoulda-context'
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
end

