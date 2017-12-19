# My Grocery Price Book Rails app
[![CircleCI](https://circleci.com/gh/my-grocery-price-book/www.svg?style=svg)](https://circleci.com/gh/my-grocery-price-book/www)
[![Waffle.io - Columns and their card count](https://badge.waffle.io/my-grocery-price-book/www.svg?columns=all)](https://waffle.io/my-grocery-price-book/www)

For development with [vagrant read this](https://github.com/my-grocery-price-book/www-infrastructure#setting-up-a-development-enviroment-with-vagrant-and-ansible)

## REQUIREMENTS

 * ruby 2.4.2
 * NodeJS
 * yarn
 * PostgreSQL
 * Imagemagick

 
### Setup
 
```
  BUNDLE_GEMFILE=Gemtools bundle install # not recommended to be added to Gemfile
  overcommit --install && overcommit --sign && overcommit --sign pre-commit
  cp -vn "config/examples/.env.local" ".env" # then edit .env and insert correct details
  bin/setup 
```

### Development

```
  ./run.sh # starts the server visit http://127.0.0.1:3000/
  bundle exec rake test # run tests
  yarn run jest spec # run javascript tests
```

#### catching email

```
  gem install mailcatcher # don't add to Gemfile
  mailcatcher --http-ip 0.0.0.0 # visit http://127.0.0.1:1080/
```
