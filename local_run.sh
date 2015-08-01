#!/bin/sh
bundle install --jobs 2
cp -vn config/examples/database.sqlite3.yml config/database.yml
bundle exec rake db:create
bundle exec rake db:migrate db:seed
bundle exec rails s -b 0.0.0.0
