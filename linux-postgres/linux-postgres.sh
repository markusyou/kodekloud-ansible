#!/bin/bash
project_name="/home/thor/kodekloud-ansible"
project_file="linux-postgres"
project_path="${project_name}/${project_file}"
echo "Install ansible and git package"
echo "Use this password: mjolnir123"
sudo yum -y install ansible git
git clone https://github.com/markusyou/kodekloud-ansible.git
cd
echo "Create hosts file in thor's homedir on jump server"
echo '
[jumphost]
locahost ansible_ssh_user=thor ansible_ssh_pass="mjolnir123" ansible_ssh_key="/home/thor/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="mjolnir123"
[apps]
stapp01 ansible_ssh_user=tony ansible_ssh_pass="Ir0nM@n" ansible_ssh_key="/home/clint/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="Ir0nM@n"  
stapp02 ansible_ssh_user=steve ansible_ssh_pass="Am3ric@" ansible_ssh_key="/home/clint/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="Am3ric@"  
stapp03 ansible_ssh_user=banner ansible_ssh_pass="BigGr33n" ansible_ssh_key="/home/clint/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="BigGr33n" 
[db]
stdb01 ansible_ssh_user=peter ansible_ssh_pass="Sp!dy" ansible_ssh_key="/home/clint/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="Sp!dy" ' \
> ${project_path}/hosts
echo "Changing directory to ${project_path}"
cd "${project_path}"
echo "Launch jump server ansible script."
ansible-playbook -i hosts jumpserver.yml
echo "Launch project ansible script"
echo "updated vars.yml, then run this command \nansible-playbook -i ./hosts ${project_file}.yml"
