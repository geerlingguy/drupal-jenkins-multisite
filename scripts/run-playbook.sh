#!/bin/bash
# Run an Ansible Playbook after installing requirements.

# The JENKINS_ENVIRONMENT should correspond to a valid inventory file.
JENKINS_ENVIRONMENT="${JENKINS_ENVIRONMENT:-local}"
cd /etc/ansible/playbook

# Install requirements.
ansible-galaxy install -r requirements.yml

# Run the playbook.
ansible-playbook -i "inventory/$JENKINS_ENVIRONMENT" main.yml --extra-vars "{jenkins_test_mode: True}"
