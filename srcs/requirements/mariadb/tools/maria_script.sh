#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

sed \
	-e "s/__MYSQL_DATABASE__/${MYSQL_DATABASE}/g" \
	-e "s/__MYSQL_USER__/${MYSQL_USER}/g" \
	-e "s/__MYSQL_PASSWORD__/${MYSQL_PASSWORD}/g" \
	-e "s/__MYSQL_ROOT_PASSWORD__/${MYSQL_ROOT_PASSWORD}/g" \
	/etc/mysql/init.sql | mariadb -u root

exec mariadbd --user=mysql