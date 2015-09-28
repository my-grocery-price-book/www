#!/bin/sh
bundle install --jobs 4 --retry 2 --path vendor/bundle
RAILS_ENV=test bundle exec rake db:create db:migrate
