Nautilus system admin's team is planning to deploy a front end application for their backup utility on Nautilus Backup Server, so that they can manage the backups of different websites from a graphical user interface. They have shared requirements to set up the same; please accomplish the tasks as per detail given below:


a. Install Apache Server on Nautilus Backup Server and configure it to use 3000 port (do not bind it to 127.0.0.1 only, keep it default i.e let Apache listen on server's IP, hostname, localhost, 127.0.0.1 etc).

b. Install Nginx webserver on Nautilus Backup Server and configure it to use 8093.

c. Configure Nginx as a reverse proxy server for Apache.

d. There is a sample index file /home/index.html on Jump Host, copy that file to Apache's document root.

e. Make sure to start Apache and Nginx services.

f. You can test final changes using curl command, e.g curl http://<backup server IP or Hostname>:8093.


------------------------------

# Redhat hat 7 solution
access.redhat.com/solutions/1225423

#/etc/nginx/conf.d/reverse.conf <--- can be any file name in the conf.d directory
upstream backendServers {
    server 192.168.122.1:8080 weight=1;
    server 192.168.122.2:8081 weight=1;
    }


# HTTP server
# Proxy with no SSL

    server {
        listen       80;
        server_name  nginx.example.com;


         location / {
         proxy_set_header Host $http_host;
         proxy_pass http://backendServers$request_uri;
        }
    }


# HTTPS server
# Proxy with SSL

    server {
        listen       443;
        server_name  nginx.example.com;

         location / {
         proxy_set_header Host $http_host;
         proxy_pass http://backendServers$request_uri;
        }

        ssl                  on;
        ssl_certificate      /etc/opt/rh/rh-nginx18/nginx/server.crt;
        ssl_certificate_key  /etc/opt/rh/rh-nginx18/nginx/server.key;

        ssl_session_timeout  5m;

        ssl_protocols  SSLv2 SSLv3 TLSv1;
        ssl_ciphers  HIGH:!aNULL:!MD5;
        ssl_prefer_server_ciphers   on;

      }
