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
#sudo systemctl enable mysql;
sudo mysql_secure_installation;
mysql -u root mysql -e "update user set plugin='mysql_native_password' where user='root';"

# Install PHP
sudo add-apt-repository ppa:ondrej/php;
sudo apt update;
sudo apt install php7.3-fpm php7.3-mbstring php7.3-xml php7.3-mysql php7.3-common php7.3-gd php7.3-json php7.3-cli php7.3-curl php7.3-soap -y;
sudo systemctl start php7.3-fpm;
sudo systemctl enable php7.3-fpm;

# Install Redis If Server Has 4GB RAM
sudo apt install redis-server php-redis;
sudo systemctl start redis-server;
sudo systemctl enable redis-server;

# Install Sendmail
#sudo apt-get install sendmail;
#sudo sendmailconfig;
#sudo nano /etc/hosts; # 127.0.0.1 localhost localhost.localdomain your_domain_name_here.com
#sudo service php7.3-fpm restart;

# Install Let's Encrypt
sudo add-apt-repository ppa:certbot/certbot;
sudo apt update;
sudo apt install certbot;
#sudo certbot certonly --manual -d *.[MYDOMAIN.COM] --agree-tos --no-bootstrap --manual-public-ip-logging-ok --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory;

# Install Let's Encrypt Automated Renewal
wget https://dl.eff.org/certbot-auto;
chmod a+x certbot-auto;
sudo mv certbot-auto /etc/letsencrypt/;

# Install Firewall
sudo apt-get install ufw;
sudo ufw disable;
sudo ufw default allow outgoing;
sudo ufw default deny incoming;
sudo ufw allow ssh;
sudo ufw allow http;
sudo ufw allow https;
sudo ufw enable;
sudo ufw status verbose;

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
chmod +x wp-cli.phar;
sudo mv wp-cli.phar /usr/local/bin/wp;

