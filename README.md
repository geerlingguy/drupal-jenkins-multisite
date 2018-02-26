# Drupal Jenkins Multisite Management Example

[![Build Status](https://travis-ci.org/geerlingguy/drupal-jenkins-multisite.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-jenkins-multisite)

TODO.

## Local Setup

### Prerequisites

  - Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
  - Install [Docker](https://docs.docker.com/install/)

### Guide

  1. Run `docker-compose up -d`
  2. Run `docker exec --tty drupal-jenkins bash -c /etc/ansible/playbook/scripts/run-playbook.sh`

After the playbook completes, visit `http://localhost:8080/`. The default login is `admin`:`admin`.

## License

BSD / MIT

## Author

This repository was created in 2018 by [Jeff Geerling](https://www.jeffgeerling.com) in support of the MidCamp 2018 session [Jenkins or: How I learned to stop worrying and love automation](https://www.midcamp.org/topic/jenkins-or-how-i-learned-stop-worrying-and-love-automation).
