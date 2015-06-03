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
  # make changes :)
  bin/rails s -b 0.0.0.0 # visit http://192.168.30.15:3000
```

# Deployment

```
  vagrant ssh
  cd project
  bin/cap vagrant deploy
```
