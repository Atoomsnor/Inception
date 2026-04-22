#!/bin/bash

# Download WP-CLI
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

# Download WordPress into the web root
mkdir -p /var/www/html
cd /var/www/html

wp core download --allow-root

# Create wp-config.php with database connection details
wp config create \
    --dbname=${MYSQL_DATABASE} \
    --dbuser=${MYSQL_USER} \
    --dbpass=${MYSQL_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

# Install WordPress
wp core install \
    --url=${DOMAIN_NAME} \
    --title=${WP_TITLE} \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --allow-root

# Create a regular subscriber user
wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --role=subscriber \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Start PHP-FPM in the foreground
exec php-fpm8.2 -F