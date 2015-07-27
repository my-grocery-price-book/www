#!/bin/sh
bundle install --jobs 2 --path vendor/bundle
cp -vn config/examples/database.sqlite3.yml config/database.yml
cp -vn config/examples/public_apis.za-ec-wc.yml config/public_apis.yml
bundle exec rake db:create
bundle exec rake db:migrate db:seed
bundle exec rails s -b 0.0.0.0
