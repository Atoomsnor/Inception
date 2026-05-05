#!/bin/bash

echo "Waiting for mariadb..."
sleep 3

mkdir -p /var/www/html
cd /var/www/html

curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
chmod +x wp-cli.phar
mv wp-cli.phar /usr/local/bin/wp

wp core download --allow-root

wp config create \
--dbname=${MYSQL_DATABASE} \
--dbuser=${MYSQL_USER} \
--dbpass=${MYSQL_PASSWORD} \
--dbhost=mariadb \
--allow-root \
--skip-check

wp core install \
--url=${DOMAIN_NAME} \
--title=${WP_TITLE} \
--admin_user=${WP_ADMIN_USER} \
--admin_password=${WP_ADMIN_PASSWORD} \
--admin_email=${WP_ADMIN_EMAIL} \
--allow-root

wp user create ${WP_USER} ${WP_USER_EMAIL} \
--role=subscriber \
--user_pass=${WP_USER_PASSWORD} \
--allow-root


sed -i "s#listen = /run/php/php8.2-fpm.sock#listen = 0.0.0.0:9000#" /etc/php/8.2/fpm/pool.d/www.conf

exec php-fpm8.2 -F