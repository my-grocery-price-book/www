# REQUIREMENTS

 * vagrant (at least 1.7.2)
 * anisible (at least 1.9.0)

# Setup with Vagrant

```
  bin/setup.sh
```

# Development

```
  vagrant ssh
  cd project
  bundle install --path vendor/bundle
  mailcatcher --http-ip 0.0.0.0 # visit http://192.168.30.15:1080/
  # make changes :)
  bin/rails s -b 0.0.0.0 # visit http://192.168.30.15:3000
  bin/spring testunit test # run tests
  bin/rake opal:spec  # run opal specs
```

# Vagrant Provision and Deployment

provisioning

```
  cd ansible
  ansible-playbook -vv site.yml
```

deploying

```
  vagrant ssh
  cd project
  bin/cap za deploy
```

# ZA Provisioning and Deployment

provisioning: Your key needs to be added to the servers and you need the vault_pass.txt

```
  cd ansible
  ansible-playbook -vv site.yml -i hosts/za --vault-password-file vault_pass.txt
```

deploying

```
  vagrant ssh
  cd project
  bin/cap za deploy
```
