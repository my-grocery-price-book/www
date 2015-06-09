source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'comfortable_mexican_sofa', '~> 1.12.0'
gem 'will_paginate'
gem 'pg'

gem 'uglifier', '>= 1.3.0' # Use Uglifier as compressor for JavaScript assets

gem 'therubyracer', platforms: :ruby # See https://github.com/rails/execjs#readme for more supported runtimes

gem 'devise' # handle authenticaton, register , forgot password, etc

gem 'puma'

gem 'rollbar' # for error collecting
gem 'newrelic_rpm' # app peformance tracking

group :development do
  gem 'capistrano', '~> 3.3'
  gem 'capistrano3-puma'
  gem 'capistrano-bundler'
  gem 'capistrano-rails' # Use Capistrano for deployment
end

group :development, :test do
  # gem 'byebug' # Call 'byebug' anywhere in the code to stop execution and get a debugger console

  gem 'spring' # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring-commands-testunit'
end

group :test do
  gem 'capybara'
end

