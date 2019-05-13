yum install epel-release -y

yum install nginx -y
systemctl start nginx
systemctl enable nginx

yum install mariadb-server mariadb -y
systemctl start mariadb
systemctl enable mariadb
mysql_secure_installation

wget http://rpms.remirepo.net/enterprise/remi-release-7.rpm
rpm -Uvh remi-release-7.rpm
yum install yum-utils -y
yum-config-manager --enable remi-php73
yum --enablerepo=remi,remi-php73 install php-fpm php-common
yum --enablerepo=remi,remi-php73 install php-opcache php-bcmath php-curl php-exif php-filter php-fileinfo php-xml php-mysqli php-openssl php-pcre php-imagick php-xml php-gd php-pecl-mcrypt php-xmlreader php-zlib php-sockets php-ftp php-cli php-pear php-pecl-redis4 php-mbstring php-soap

nano /etc/php.ini
#cgi.fix_pathinfo=0

nano /etc/nginx/conf.d/default.conf
#server {
#    listen 80;
#    server_name localhost;
#    root /usr/share/nginx/html;
#    index index.php index.html index.htm;
#    location / {
#        try_files $uri $uri/ =404;
#    }
#    error_page 404 /404.html;
#    error_page 500 502 503 504 /50x.html;
#    location = /50x.html {
#        root /usr/share/nginx/html;
#    }
#    location ~ \.php$ {
#        try_files $uri =404;
#        fastcgi_pass unix:/var/run/php-fpm/php-fpm.sock;
#        fastcgi_index index.php;
#        fastcgi_param SCRIPT_FILENAME $document_root$fastcgi_script_name;
#        include fastcgi_params;
#    }
#}

systemctl restart nginx

nano /etc/php-fpm.d/www.conf
#user = apache to user = nginx
#group = apache to group = nginx
#listen.owner = nobody to listen.owner = nginx
#listen.group = nobody to listen.group = nginx
#listen = /var/run/php-fpm/php-fpm.sock

systemctl start php-fpm.service
systemctl enable php-fpm.service


systemctl stop firewalld
systemctl disable firewalld

yum install redis wget zip htop -y
systemctl start redis
systemctl enable redis

# Install Firewall
yum install ufw
ufw disable
ufw default allow outgoing
ufw default deny incoming
ufw allow ssh
ufw allow http
ufw allow https
ufw enable
ufw status verbose

# Install WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
sudo mv wp-cli.phar /usr/local/bin/wp
