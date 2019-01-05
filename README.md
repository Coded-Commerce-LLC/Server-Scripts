# Server Scripts

Used for site copying as subdomains, deleting sites from command line, and adding a UI into a master WordPress site to create copies.

## Prerequisites

This was tested on Ubuntu 18.04 LTS using NginX web server. Modifications are likely in different environments.

## Installing LEMP - Recommended PHP Settings ##

Set these within `/etc/php/7.2/fpm/php.ini` then run `sudo service php7.2-fpm restart`

```
PHP memory_limit:	256 MB
PHP post_max_size:	100 MB
PHP max_execution_time:	120
PHP max_input_vars:	10000
PHP max_upload_size:	100 MB
```

## Installing LEMP - Nginx Vritual Hosts ##

```
server {
	listen 80;
	listen [::]:80;
	server_name demo.acceleratedstore.com;
	return 301 https://$server_name$request_uri;
}

server {
	listen 443 ssl;
	listen [::]:443 ssl;
	server_name demo.acceleratedstore.com;
	access_log /var/log/nginx/astore-demo.access.log;
	error_log /var/log/nginx/astore-demo.error.log warn;
	ssl on;
	ssl_certificate /etc/letsencrypt/live/acceleratedstore.com-0001/fullchain.pem;
	ssl_certificate_key /etc/letsencrypt/live/acceleratedstore.com-0001/privkey.pem;
	ssl_session_timeout 5m;
	root /var/www/html/demo.acceleratedstore.com;
	index index.html index.htm index.php;
	location / {
		try_files $uri $uri/ /index.php?$args;
	}
	location ~ \.php$ {
		include snippets/fastcgi-php.conf;
		fastcgi_pass unix:/var/run/php/php7.2-fpm.sock;
	}
}
```

## Setting Up Copysite / Deletesite Scripts

From SSH terminal run the commend `sudo visudo` and append the following line giving the web server the ability to run this root shell script:
```
www-data ALL = NOPASSWD: /root/copysite.sh
```

## Author

* **Coded Commerce, LLC** - *Initial work* - [Coded-Commerce-LLC](https://github.com/Coded-Commerce-LLC)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
