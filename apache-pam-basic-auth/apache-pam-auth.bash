#!/bin/bash
echo "Install ansible package"
echo "Use this password: mjolnir123"
sudo yum -y install ansible
echo "Create hosts file in thor's homedir on jump server"
echo '
[jumphost]
locahost ansible_ssh_user=tony ansible_ssh_pass="mjolnir123" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="mjolnir123"
[apps]
stapp01 ansible_ssh_user=tony ansible_ssh_pass="Ir0nM@n" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="Ir0nM@n"
stapp02  ansible_ssh_user=steve ansible_ssh_pass="Am3ric@" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub"  ansible_become_user=root ansible_become_pass="Am3ric@"
stapp03 ansible_ssh_user=banner ansible_ssh_pass="BigGr33n" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub"  ansible_become_user=root ansible_become_pass="BigGr33n"' \
> ~/hosts
echo "Create ansible script to config jump server"
cat << 'EOF' > ~/jumpsvr.yml
---
- name: Setup up ssh creds for jump server
  gather_facts: false
  hosts: 127.0.0.1
  connection: local

  vars:
    ssh_key_filename: id_rsa

  tasks:
    - name: Update /etc/ansible/ansible.cfg
      become: true
      lineinfile:
        dest: "/etc/ansible/ansible.cfg"
        state: present
        regexp: '^#host_key_checking'
        line: 'host_key_checking = False'

    - name: Create a directory if it does not exist
      file:
        path: "/home/thor/.ssh/"
        state: directory
        mode: '0700'
        owner: thor
        group: thor

    - name: generate SSH key "{{ssh_key_filename}}"
      openssh_keypair:
        path: "~/.ssh/{{ssh_key_filename}}"
        type: rsa
        size: 4096
        state: present
        force: no

EOF

echo "Launch jump server ansible script.. tweak to /etc/ansible/ansible.cfg"
ansible-playbook -i ./hosts jumpsvr.yml
echo "Create app server ansible script"
cat << 'EOF' > ~/apps.yml
---
- name: Configure application servers for Apache Pam Auth
  gather_facts: false
  become: true
  hosts: apps
  tasks:
    - name: Set authorized key taken from file
      authorized_key:
        user: "{{ ansible_ssh_user }}"
        state: present
        key: "{{ lookup('file', '/home/thor/.ssh/id_rsa.pub') }}"

    - name: Allow 'wheel' group to have passwordless sudo
      lineinfile:
        dest: /etc/sudoers
        state: present
        regexp: '^%wheel'
        line: '%wheel ALL=(ALL) NOPASSWD: ALL'
        validate: 'visudo -cf %s'

    - name: Install package with repo enabled
      yum:
        name: "mod_authnz_external"
        enablerepo: epel

    - name: Install package with repo enabled
      yum:
        name: "pwauth"
        enablerepo: epel

    - name:  Update Basic Pam auth configuration
      blockinfile:
        path: /etc/httpd/conf.d/authnz_external.conf
        block: |
          <Directory /var/www/html/protected>
             AuthType Basic
             AuthName "PAM Authentication"
             AuthBasicProvider external
             AuthExternal pwauth
             require valid-user
           </Directory>
        backup: false

    - name: Restart service httpd, in all cases
      service:
        name: httpd
        state: restarted
EOF

echo "Launch app server ansible script"
ansible-playbook -i ./hosts apps.yml

