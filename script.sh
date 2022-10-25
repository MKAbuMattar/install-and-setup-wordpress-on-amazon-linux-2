#!/bin/bash

# Update the system
sudo yum update -y

# Create a user
sudo useradd -m -s /bin/bash $1

# Add the user to the sudo group
sudo usermod -aG wheel $1

# Set a password for the user
echo $2 | sudo passwd --stdin $1

# Force the user to change the password after 1 day and disable the account after 180 days
sudo chage -m 1 -M 180 $1

# The password expiration
sudo passwd -e $1

# Install Apache
sudo yum install httpd -y

# Start Apache
sudo systemctl start httpd

# Enable Apache
sudo systemctl enable httpd

# At first, we will enable amazon-linux-extras so that we can specify the PHP version that we want to install.
sudo amazon-linux-extras enable php7.4 -y

# Install PHP
sudo yum install php php-{pear,cgi,common,curl,mbstring,gd,mysqlnd,gettext,bcmath,json,xml,fpm,intl,zip,imap} -y

# Install MariaDB
sudo yum install mariadb-server -y

# Start MariaDB
sudo systemctl start mariadb

# Enable MariaDB
sudo systemctl enable mariadb

# Restart Apache
sudo systemctl restart httpd

# We will now secure MariaDB.
sudo mysql_secure_installation <<EOF

y
$3
$3
y
y
y
y
EOF

# Download WordPress
sudo wget https://wordpress.org/latest.tar.gz

# Extract WordPress
sudo tar -xvzf latest.tar.gz

# Add the user to the apache group
sudo usermod -a -G apache $1

# Change the ownership of the /var/www directory to the apache user and group.
sudo chown -R apache:apache /var/www

# This will give read, write, and execute permissions to the owner, group, and others.
sudo chmod -R 775 /var/www

# This is for the wp-config.php file
sudo chmod -R 755 /var/www/html

# Move WordPress to /var/www/html
sudo mv wordpress /var/www/html

# Change the ownership of the WordPress directory to apache user and group.
sudo chown -R apache:apache /var/www/html/wordpress

# Change the permissions of the WordPress directory.
sudo chmod -R 755 /var/www/html/wordpress

# root password argument 3
# database name argument 4
# database user argument 5
# database user password argument 6
# Create a WordPress database
sudo mysql -u root -p$3 <<EOF
CREATE DATABASE $4;
CREATE USER $5@localhost IDENTIFIED BY '$6';
GRANT ALL PRIVILEGES ON $4.* TO $5@localhost;
FLUSH PRIVILEGES;
exit
EOF

# Restart MariaDB
sudo systemctl restart mariadb

# Permissions wp-config.php file
sudo cp /var/www/html/wordpress/wp-config-sample.php /var/www/html/wordpress/wp-config.php

# Change the ownership of the wp-config.php file to the apache user and group.
sudo chown apache:apache /var/www/html/wordpress/wp-config.php

# Change the permissions of the wp-config.php file.
sudo chmod 640 /var/www/html/wordpress/wp-config.php

# Add the database name, database user, and database user password to the wp-config.php file.
sudo sed -i "s/database_name_here/$4/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/username_here/$5/g" /var/www/html/wordpress/wp-config.php
sudo sed -i "s/password_here/$6/g" /var/www/html/wordpress/wp-config.php

# Restart Apache
sudo systemctl restart httpd

echo "WordPress is installed"