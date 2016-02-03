[![Build Status](https://semaphoreci.com/api/v1/projects/9e86687d-5794-45da-96f0-ebd507dddd33/683754/badge.svg)](https://semaphoreci.com/my-grocery-price-book/www)

# Setup with Vagrant

## REQUIREMENTS

 * vagrant (at least 1.7.2)
 * anisible (at least 1.9.0)

```
  vagrant dns --install
  vagrant up
  vagrant ssh # you can visit http://www.groc-dev/
  cd project
  bundle exec rake opal:spec test # run tests
  ./run.sh # run development db server
```

# Setup without Vagrant

## REQUIREMENTS

 * ruby 2.2
 * PostgreSQL
 * Imagemagick
 
```
  cp -vn "config/examples/.env.local" ".env" # then edit .env and insert correct details
  bin/setup.sh 
  ./run.sh # run development db server
  bundle exec rake test opal:spec # run tests
```

# Development

```
  bundle install --path vendor/bundle
  # make changes :)
  bin/rails s -b 0.0.0.0 # visit http://192.168.30.15:3000
  bin/spring testunit test # run tests
  bin/rake opal:spec  # run opal specs
```

catching email

```
  gem install mailcatcher # don't add to Gemfile, this step is already done for vagrant/ansible
  mailcatcher --http-ip 0.0.0.0 # vagrant visit: http://192.168.30.15:1080/, local visit http://127.0.0.1:1080/
```

# Vagrant Provision and Deployment

provisioning

```
  cd ansible
  ansible-playbook -vv site.yml
```

# ZA Provisioning and Deployment

provisioning: Your key needs to be added to the servers and you need the vault_pass.txt

```
  cd ansible
  ansible-playbook -vv site.yml -i hosts/za --vault-password-file vault_pass.txt
```
