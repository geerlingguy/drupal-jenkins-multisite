# Drupal Jenkins Multisite Management Example

[![Build Status](https://travis-ci.org/geerlingguy/drupal-jenkins-multisite.svg?branch=master)](https://travis-ci.org/geerlingguy/drupal-jenkins-multisite)

This repository contains a working example of a Jenkins server set up to manage a Drupal multisite installation on a separate server.

## Local Setup

**Prerequisites**:

  - Install [Docker](https://docs.docker.com/install/)

**Guide**:

  1. Run `docker-compose up -d`
  2. Run `docker exec --tty drupal-jenkins bash -c /etc/ansible/playbook/scripts/run-playbook.sh`

After the playbook completes, visit `http://localhost:8080/`. The default login is `admin`:`admin`.

## Production Setup

For production, this project uses [Ansible Vault](http://docs.ansible.com/ansible/2.4/vault.html) to store an encrypted copy of the Jenkins admin password (so even developers with access to this repository would still not be able to access the Jenkins super administrator account unless you explicitly give them access!).

In this example, we'll install Jenkins on a DigitalOcean Droplet (a VPS), but you can use this playbook anywhere that hosts VPSes—Linode, AWS EC2, Hertzner, etc.

**Prerequisites**:

  - Install [Ansible](http://docs.ansible.com/ansible/latest/intro_installation.html)
  - Set up your Ansible Vault secrets:
    1. Create a file at `~/.ansible/drupal-jenkins-vault-password.txt` and put in a unique, random, securely-generated password (e.g. `MZjDUcMsUeKpq9vaXoCyYDwFNrMF3E`).
    2. Run the command: `ansible-vault create vars/secrets.yml --vault-passw
ord-file=~/.ansible/drupal-jenkins-vault-password.txt`, and save the file that is generated (it's okay if it's empty right now).

**Guide**:

  1. Create a VPS somewhere to which you have root SSH access; choose Ubuntu 16.04 for the OS.
  2. Create an prod inventory file (e.g. `inventory/prod`) containing the IP address or domain name of the VPS:

         [jenkins]
         drupal-jenkins-multisite.example.com
         
         [jenkins:vars]
         ansible_ssh_user=root

  4. Edit the `vars/secrets.yml` file (with the same command as earlier, but with `edit` instead of `create`), and add the following:

         jenkins_admin_password: [generate a secure random password]
         nginx_proxy_vhostname: "drupal-jenkins-multisite.example.com"
         certbot_admin_email: https@example.com
         certbot_certs:
           - email: "https@example.com"
             domains:
               - "{{ nginx_proxy_vhostname }}"

  3. Run the command: `ansible-playbook -i inventory/prod main.yml --vault-password-file=~/.ansible/drupal-jenkins-vault-password.txt --extra-vars "{certbot_create_standalone_stop_services: []}"`

After the playbook completes, you should be able to access the Jenkins server at the IP address or hostname of the server (e.g. https://drupal-jenkins-multisite.jeffgeerling.com/ in the example above).

> **Note**: In the future, run the same `ansible-playbook` command to update the server or update configurations—but leave off the `--extra-vars` (that setting is only necessary on the first run).

## License

BSD / MIT

## Author

This repository was created in 2018 by [Jeff Geerling](https://www.jeffgeerling.com) in support of the MidCamp 2018 session [Jenkins or: How I learned to stop worrying and love automation](https://www.midcamp.org/topic/jenkins-or-how-i-learned-stop-worrying-and-love-automation).
