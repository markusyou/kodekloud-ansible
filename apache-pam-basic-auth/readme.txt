#readme
#Setup the environment to allow for running ansible playbooks against target hosts

# on jump host 
# install ansible 
# change /etc/ansible/ansible.cfg to all password use in inventory file. 
#    /etc/ansibe/ansible.cfg - host_key_checking = False# 
# ssh-keygen for thor
# Create host file
#
# copy thor public key to each of the remote hosts unique login ids
# eg: stapp01 tony/.ssh/authorized_keys
# eg: stapp02 steve/.ssh/authorized_keys
# eg: stapp03 banner/.ssh/authorized_keys

Reference:
yum install two auth modules for apache - see https://www.server-world.info/en/note?os=CentOS_7&p=httpd&f=10
config file: /etc/httpd/conf.d/authnz_external.conf

<Directory /var/www/html/protected>
    AuthType Basic
    AuthName "PAM Authentication"
    AuthBasicProvider external
    AuthExternal pwauth
    require valid-user
</Directory>

Directions for task from KodeKloud
The document root /var/www/html of all web apps is on NFS share /data on storage server in Stratos Datacenter. We have a requirement where we want to password protect a directory in Apache web server document root. We want to password protect http://<website-url>:<apache_port>/protected URL as per below given requirements (you can use any website-url for it like localhost since there are no such specific requirements as of now):

a. We want to use basic authentication.
b. We do not want to use htpasswd file base authentication instead we want to use PAM authentication i.e Basic Auth + PAM. So that we can authenticate with a Linux user itself.
c. We already have a user james with password GyQkFRVNr3 which you need to provide access.
d. You can access the website on LBR link, to do so click on the + button on top of your terminal and select option Select port to view on Host 1 and after adding port 80 click on Display Port.


 