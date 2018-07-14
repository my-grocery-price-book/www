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
  docker-compose run --rm app bin/setup
```

### Development

```
  docker-compose up # starts the server visit http://127.0.0.1:3000/
  docker-compose run --rm app bundle exec rake test # run tests
  docker-compose run --rm app yarn run jest spec # run javascript tests
```

#### catching email

```
  gem install mailcatcher # don't add to Gemfile
  mailcatcher --http-ip 0.0.0.0 # visit http://127.0.0.1:1080/
```
