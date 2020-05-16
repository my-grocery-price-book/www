#!/usr/bin/env bash
set -eo pipefail

echo '-- cypress run'
yarn install
yarn run cypress install
yarn run cypress run -P test
