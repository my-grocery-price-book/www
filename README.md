# REQUIREMENTS

 * vagrant (at least 1.7.2)
 * anisible (at least 1.9.0)

# Development Setup with Vagrant
```
  vagrant up
  ssh-add .vagrant/machines/default/virtualbox/private_key
  cd ansible && ansible-playbook site.yml
  vagrant ssh
  cd project
  bundle install --path vendor/bundle
```


# Deployment
```
  vagrant ssh
  cd /vagrant
```
