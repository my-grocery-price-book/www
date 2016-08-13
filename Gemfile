source 'https://rubygems.org'

group :development, :test do
  gem 'dotenv-rails' # load before other gems
end

gem 'rails', '~> 5.0.0'

gem 'sprockets'
gem 'jbuilder'
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
gem 'countries', require: false # for country currency information
gem 'oj'
gem 'multi_json'

gem 'component_library'

group :development do
  gem 'annotate', require: false
end

group :development, :test do
  # gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'spring', require: false # Spring speeds up development by keeping your application running in the background
  gem 'spring-commands-testunit', require: false
  gem 'spring-commands-teaspoon', require: false
  gem 'teaspoon-jasmine'
  gem 'coffee-script' # needed for teaspoon-jasmine https://github.com/modeset/teaspoon/issues/405
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara', require: false
  gem 'capybara-email', require: false
  gem 'poltergeist', require: false
  gem 'shoulda-context'
  gem 'simplecov', require: false
  gem 'database_cleaner', require: false
  gem 'phantomjs', require: false
  gem 'puma', require: false
  gem 'rails-controller-testing' # https://github.com/rails/rails-controller-testing
end
