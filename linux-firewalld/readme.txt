To secure our Nautilus infrastructure in Stratos Datacenter we have decided to install and configure firewalld on all app servers. We have Apache and Nginx services running on these apps. Nginx is running as a reverse proxy server for Apache. We might have more robust firewall settings in future but for now we have decided to go with below given requirements:


a. Allow all incoming connections on Nginx port.

b. Allow incoming connections from LB host only on Apache port and block for rest.

c. All rules must be permanent.

d. Zone should be public.

e. If Apache or Nginx services aren't running already please make sure to start them.

sudo yum install firewalld
sudo yum install apache
sudo yum install nginx
sudo service enable firewalld
sudo service enable apache
sudo service enable nginx

Configure firewalld 


# Port 80 open (Ngnix incoming connections)
firewall-cmd --permanent --zone=public --add-service=http 

# Port 80 open (Ngnix incoming connections)
firewall-cmd --permanent --zone=public --add-service=http 



Load firewall rule changes
sudo firewall-cmd --reload

yum -y install nginx httpd firewalld
systemctl restart nginx
systemctl restart httpd
systemctl restart firewalld
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --permanent --zone=public --add-rich-rule 'rule family="ipv4" source address="172.16.238.14" port port=8080 protocol=tcp accept'
