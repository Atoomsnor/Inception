#!/bin/bash

mkdir -p /run/mysqld
chown -R mysql:mysql /run/mysqld

sed -i \
	-e "s/__MYSQL_DATABASE__/${MYSQL_DATABASE}/g" \
	-e "s/__MYSQL_USER__/${MYSQL_USER}/g" \
	-e "s/__MYSQL_PASSWORD__/${MYSQL_PASSWORD}/g" \
	-e "s/__MYSQL_ROOT_PASSWORD__/${MYSQL_ROOT_PASSWORD}/g" \
	/etc/mysql/init.sql

if [ ! -d "/var/lib/mysql/${MYSQL_DATABASE}" ]; then
	exec mariadbd --user=mysql --init-file=/etc/mysql/init.sql
else
	exec mariadbd --user=mysql
fi