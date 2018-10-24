#!/bin/bash

if [ "$#" -ne 1 ]

then

	echo "Missing argument [site_name]";

else

	# Delete Web Folder
	rm -rf /var/www/html/$1.[DOMAIN.COM];

	# Delete DB
	echo "DROP DATABASE IF EXISTS $1" | mysql -u root -p[MYSQL_PASSWORD];

	# Delete Web Server
	cd /etc/nginx/sites-available;
	rm $1.[DOMAIN.COM];
	cd ../sites-enabled;
	rm $1.[DOMAIN.COM];
	service nginx reload;

fi
