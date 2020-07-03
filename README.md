# My Grocery Price Book Rails app
[![CircleCI](https://circleci.com/gh/my-grocery-price-book/www.svg?style=svg)](https://circleci.com/gh/my-grocery-price-book/www)

Currently hosted on heroku: http://my-grocery-price-book.herokuapp.com/

## REQUIREMENTS

 * ruby 2.4.10
 * NodeJS
 * yarn
 * PostgreSQL
 * Imagemagick

 
### Setup
 
```
  BUNDLE_GEMFILE=Gemtools bundle install # not recommended to be added to Gemfile
  gem install overcommit && bin/overcommit --install && bin/overcommit --sign && bin/overcommit --sign pre-commit
  docker-compose build --build-arg UID=$(id -u) --build-arg GID=$(id -g)
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
