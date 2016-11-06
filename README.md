# My Grocery Price Book Rails app

[![Build Status](https://semaphoreci.com/api/v1/projects/9e86687d-5794-45da-96f0-ebd507dddd33/683754/badge.svg)](https://semaphoreci.com/my-grocery-price-book/www)
[![Stories in Ready](https://badge.waffle.io/my-grocery-price-book/www.png?label=ready&title=Ready)](https://waffle.io/my-grocery-price-book/www)

For development with [vagrant read this](https://github.com/my-grocery-price-book/www-infrastructure#setting-up-a-development-enviroment-with-vagrant-and-ansible)

## REQUIREMENTS

 * ruby 2.3.1
 * PostgreSQL
 * Imagemagick

 
### Setup
 
```
  BUNDLE_GEMFILE=Gemtools bundle install # not recommended to be added to Gemfile
  overcommit --install && overcommit --sign && overcommit --sign pre-commit
  cp -vn "config/examples/.env.local" ".env" # then edit .env and insert correct details
  bundle install
  bin/setup 
```

### Development

```
  ./run.sh # starts the server
  bin/spring testunit test # run tests
  bin/teaspoon spec # run javascript tests
```

#### catching email

```
  gem install mailcatcher # don't add to Gemfile, this step is already done for vagrant/ansible
  mailcatcher --http-ip 0.0.0.0 # vagrant visit: http://192.168.30.15:1080/, local visit http://127.0.0.1:1080/
```