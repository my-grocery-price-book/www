#!/bin/sh
bundle install
bundle exec rake db:create
bundle exec rake db:migrate db:seed
bundle exec rails s -b 0.0.0.0
