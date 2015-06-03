#!/bin/sh
vagrant up
ssh-add .vagrant/machines/default/virtualbox/private_key
cd ansible && ansible-playbook site.yml && cd ..
