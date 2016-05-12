#!/usr/bin/env bash
bundle install # install gems for current rails version, creates Gemfile.lock
BUNDLE_GEMFILE=Gemfile-next bundle install # install gems for next rails version, creates Gemfile-next.lock