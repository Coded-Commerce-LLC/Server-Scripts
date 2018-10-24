#!/bin/bash

if [ "$#" -ne 2 ]

then

	echo "Missing argument [from_site_name] [to_site_name]";

else

	# Make Web Folder
	mkdir /var/www/html/$2.[DOMAIN.COM];
	cd /var/www/html/$2.[DOMAIN.COM];

	# Copy Site From Master
	cp -a ../$1.[DOMAIN.COM]/* .;
	rm -rf wp-content/mu-plugins;
	perl -p -i -e "s/$1/$2/g" wp-config.php;

	# Copy DB From Master
	echo "create database $2" | mysql -u root -p[MYSQL_PASSWORD];
	mysqldump -u root -p[MYSQL_PASSWORD] $1 > db.sql;
	mysql -u root -p[MYSQL_PASSWORD] "$2" < db.sql;
	echo "use $2; update wp_options set option_value = 'https://$2.[DOMAIN.COM]' where option_name in ( 'siteurl', 'home' );" | mysql -u root -p[MYSQL_PASSWORD];
	echo "use $2; update wp_options set option_value = concat( upper( '$2' ), ' WooCommerce Site' ) where option_name = 'blogdescription';" | mysql -u root -p[MYSQL_PASSWORD];
	rm db.sql;

	# Setup Web Server
	cd /etc/nginx/sites-available;
	cp $1.[DOMAIN.COM] $2.[DOMAIN.COM];
	perl -p -i -e "s/$1\.topdomain\.com/$2\.topdomain\.com/g" $2.[DOMAIN.COM];
	cd ../sites-enabled;
	ln -s /etc/nginx/sites-available/$2.[DOMAIN.COM];
	service nginx reload;

fi
