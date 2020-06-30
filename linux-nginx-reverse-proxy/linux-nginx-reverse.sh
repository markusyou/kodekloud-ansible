#!/bin/bash
project_name="/home/thor/kodekloud-ansible"
project_file="linux-nginx-reverse-proxy"
project_path="${project_name}/${project_file}"
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
stbkup ansible_ssh_user=clint ansible_ssh_pass="H@wk3y3" ansible_ssh_key="/home/clint/.ssh/id_rsa.pub" ansible_become_user=root ansible_become_pass="H@wk3y3" ' \
> ${project_path}/hosts
echo "Changing directory to ${project_path}"
cd "${project_path}"
echo "Launch jump server ansible script."
ansible-playbook -i hosts jumpserver.yml
echo "Launch project ansible script"
ansible-playbook -i ./hosts ${project_file}.yml
