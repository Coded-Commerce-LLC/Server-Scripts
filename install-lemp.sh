#!/bin/bash

# Update Repos
sudo apt update;
sudo apt upgrade -y;

# Install Web Server
sudo apt install nginx -y;
sudo systemctl start nginx;
sudo systemctl enable nginx;

# Install Database
sudo apt install mariadb-server mariadb-client -y;
sudo systemctl start mysql;
sudo systemctl enable mysql;
sudo mysql_secure_installation;

# Install PHP
sudo apt install php7.2-fpm php7.2-mbstring php7.2-xml php7.2-mysql php7.2-common php7.2-gd php7.2-json php7.2-cli php7.2-curl php7.2-soap -y;
sudo systemctl start php7.2-fpm;
sudo systemctl enable php7.2-fpm;

# Install Redis If Server Has 4GB RAM
sudo apt install redis-server php-redis;
sudo systemctl start redis-server;
sudo systemctl enable redis-server;

# Install Sendmail
#sudo apt-get install sendmail;
#sudo sendmailconfig;
#sudo nano /etc/hosts; # 127.0.0.1 localhost localhost.localdomain your_domain_name_here.com
#sudo service php7.2-fpm restart;

# Install Let's Encrypt
sudo add-apt-repository ppa:certbot/certbot;
sudo apt update;
sudo apt install certbot;
#sudo certbot certonly --manual -d *.[MYDOMAIN.COM] --agree-tos --no-bootstrap --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory;

# Install Let's Encrypt Automated Renewal
wget https://dl.eff.org/certbot-auto;
chmod a+x certbot-auto;
sudo mv certbot-auto /etc/letsencrypt/;

