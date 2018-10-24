# Server Scripts

Used for site copying as subdomains, deleting sites from command line, and adding a UI into a master WordPress site to create copies.

## Prerequisites

This was tested on Ubuntu 18.04 LTS using NginX web server. Modifications are likely in different environments.

## Setting It Up

From SSH terminal run the commend `sudo visudo` and append the following line giving the web server the ability to run this root shell script:
```
www-data ALL = NOPASSWD: /root/copysite.sh
```

## Author

* **Coded Commerce, LLC** - *Initial work* - [Coded-Commerce-LLC](https://github.com/Coded-Commerce-LLC)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details
