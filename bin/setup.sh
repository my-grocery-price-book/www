#!/bin/sh
vagrant up
ssh-add .vagrant/machines/default/virtualbox/private_key
cd ansible && ansible-playbook -vv site.yml && cd ..
