# Install and Setup WordPress on Amazon Linux 2

## Description

This script will install and setup WordPress on Amazon Linux 2.

## Prerequisites

- Amazon Linux 2
- Root access

## Packages Installed

- Apache Web Server
- PHP and MariaDB
- WordPress

## Configuration at Script

- Create a user
- Add the user to the sudo group
- Set a password for the user
- Force the user to change the password after 1 day and disable the account after 180 days
- The password expiration
- Install Apache
- Start Apache
- Enable Apache
- At first, we will enable amazon-linux-extras so that we can specify the PHP version that we want to install.
- Install PHP
- Install MariaDB
- Start MariaDB
- Enable MariaDB
- Restart Apache
- We will now secure MariaDB.
- Download WordPress
- Extract WordPress
- Add the user to the apache group
- Change the ownership of the /var/www directory to the apache user and group.
- This will give read, write, and execute permissions to the owner, group, and others.
- This is for the wp-config.php file
- Move WordPress to /var/www/html
- Change the ownership of the WordPress directory to apache user and group.
- Change the permissions of the WordPress directory.
- Create a WordPress database
- Restart MariaDB
- Permissions wp-config.php file
- Change the ownership of the wp-config.php file to the apache user and group.
- Change the permissions of the wp-config.php file.
- Add the database name, database user, and database user password to the wp-config.php file.
- Restart Apache

## Usage

```bash
sudo bash /home/<ec2-user>/script.sh <username> <password> <root password> <database name> <database user> <database user password>
```

## Example

```bash
sudo bash /home/ec2-user/script.sh mkabumattar 121612 121612 wordpressdb wordpressuser password
```

## Author

[Mohamed Abu Mattar](https://mkabumattar.github.io/)

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details

## Acknowledgments

- [AWS - Amazon Linux 2](https://aws.amazon.com/amazon-linux-2/)
- [WordPress](https://wordpress.org/)
- [Apache HTTP Server](https://httpd.apache.org/)
- [PHP](https://www.php.net/)
- [MariaDB](https://mariadb.org/)

## References

- [How to Install Apache Web Server on Amazon Linux 2](https://mkabumattar.vercel.app/blog/post/how-to-install-apache-web-server-on-amazon-linux-2)
- [How to Install PHP and MariaDB on Amazon Linux 2](https://mkabumattar.vercel.app/blog/post/how-to-install-php-and-mariadb-on-amazon-linux-2)
- [How to Install WordPress on Amazon Linux 2](https://mkabumattar.vercel.app/blog/post/how-to-install-wordpress-on-amazon-linux-2)

## Disclaimer

This script is for educational purposes only. Use at your own risk.

## Support

If you have any questions, please contact me at [GitHub](www.github.com/mkabumattar).
