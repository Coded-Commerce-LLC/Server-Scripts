#!/bin/bash

# Server Software
sudo apt-get update && sudo apt-get upgrade -y && sudo apt-get dist-upgrade -y && sudo apt-get autoremove;

# Web Permissions
sudo chown -R www-data:www-data /var/www; sudo chmod -R 775 /var/www;

# LetsEncrypt Renewal
cd /etc/letsencrypt/ && ./certbot-auto renew && service nginx reload

# WP CLI
sudo wp cli update;

# WP Sites
for f in /var/www/html/*;
	do
		[ -d $f ] \
		&& cd "$f" \
		&& echo "Updating $f" \
		&& wp --allow-root plugin update --all \
		&& wp --allow-root theme update --all \
		&& wp --allow-root core update
done;
