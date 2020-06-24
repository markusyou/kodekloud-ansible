#!/bin/bash
echo "Install ansible and git package"
echo "Use this password: mjolnir123"
sudo yum -y install ansible git
git clone https://github.com/markusyou/kodekloud-ansible.git
cd 
echo "Create hosts file in thor's homedir on jump server"
echo '
[jumphost]
locahost ansible_ssh_user=tony ansible_ssh_pass="mjolnir123" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="mjolnir123"
[apps]
stapp01 ansible_ssh_user=tony ansible_ssh_pass="Ir0nM@n" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="Ir0nM@n"
stapp02  ansible_ssh_user=steve ansible_ssh_pass="Am3ric@" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub"  ansible_become_user=root ansible_become_pass="Am3ric@"
stapp03 ansible_ssh_user=banner ansible_ssh_pass="BigGr33n" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub"  ansible_become_user=root ansible_become_pass="BigGr33n" '\
> /home/thor/kodekloud-ansible/linux-firewalld/hosts 
cd /home/thor/kodekloud-ansible/linux-firewalld
echo "Launch jump server ansible script."
echo "ansible-playbook -i ./hosts jumpserver.yml"
echo "Launch nfs server ansible script"
echo "ansible-playbook -i ./hosts linux-firewall.yml"
