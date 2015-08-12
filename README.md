# Setup with Vagrant

## REQUIREMENTS

 * vagrant (at least 1.7.2)
 * anisible (at least 1.9.0)

```
  vagrant up
  vagrant ssh
  cd project
  ./run.sh
```

# Setup without Vagrant

## REQUIREMENTS

 * ruby 2.2
 * PostgreSQL
 * Imagemagick
 
```
  bin/setup.sh
  ./run.sh
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
