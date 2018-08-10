#!/usr/bin/env bash
set -eo pipefail

echo '-- start rails server'
bundle exec ./bin/rails server -p 5002 -e test &
sleep 2 # give rails a chance to start up correctly

echo '-- cypress run'
yarn run cypress install
yarn run cypress run -P test
