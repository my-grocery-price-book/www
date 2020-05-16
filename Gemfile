# frozen_string_literal: true

source 'https://rubygems.org'

ruby '2.4.10'

group :development, :test do
  gem 'dotenv-rails' # load before other gems
end

gem 'rails', '~> 5.0.0'
gem 'bootsnap', require: false
gem 'webpacker'
gem 'webpacker-react', '>= 0.3.2'

gem 'sprockets'
gem 'jbuilder'
gem 'pg'

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

gem 'devise' # handle authenticaton, register , forgot password, etc
gem 'intercom-rails' # monitor shoppers

gem 'rollbar' # for error collecting
gem 'newrelic_rpm' # app peformance tracking

gem 'faraday', require: false # for making http request
gem 'carmen', require: false # for country and region information
gem 'countries', require: false # for country currency information
gem 'money', '>= 6.9', require: false

gem 'oj'
gem 'multi_json'

gem 'component_library'

gem 'puma', require: false

group :development do
  gem 'annotate', require: false
end

group :development, :test do
  # gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring', require: false # Spring speeds up development by keeping your application running in the background
  gem 'spring-commands-testunit', require: false
  gem 'cypress-on-rails', '~> 1.0'
  gem 'devise-bootstrapped'
end

group :test do
  gem 'webmock'
  gem 'factory_girl_rails'
  gem 'capybara', require: false
  gem 'capybara-email', require: false
  gem 'poltergeist', require: false
  gem 'shoulda-context'
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
  gem 'phantomjs', require: false
  gem 'rails-controller-testing' # https://github.com/rails/rails-controller-testing
end
