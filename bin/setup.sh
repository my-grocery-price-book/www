#!/bin/sh
bundle install --jobs 4 --retry 2 --path vendor/bundle
cp -vn "config/examples/.env.local" ".env"
