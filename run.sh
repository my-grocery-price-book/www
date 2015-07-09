#!/bin/sh
bin/rake db:migrate db:seed
bin/rails s -b 0.0.0.0
