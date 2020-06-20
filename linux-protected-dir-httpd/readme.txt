xFusionCorp Industries has hosted some static websites on Nautilus Application Servers in Stratos DC. There are some confidential directories on document root that need to be password protected. Since they are using Apache for hosting the websites so production support team has decided to use .htaccess with basic auth. There is a website needs to be uploaded to /var/www/html/sysops on Nautilus App Server 3. But before that we need to setup the authentication.


1. Create /var/www/html/sysops direcotry if doesn't exist.

2. Add an user javed in htpasswd and set its password to ksH85UJjhb.

3. There is a file /tmp/index.html placed on Jump Server. Copy the same to new directory you created, please make sure default document root should remain /var/www/html.
