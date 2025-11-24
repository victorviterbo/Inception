#!/bin/bash

set -e

mysqld --datadir='/var/lib/mysql' &

MYSQL_PID=$!
echo MYSQL_PID

echo $MYSQL_PID

sleep 10000000000

mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || mariadb -u root -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || mariadb -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || echo "failed cmd 1" && exit 1

mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" || echo "failed cmd 2" && exit 1
mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" || echo "failed cmd 3" && exit 1
mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" || echo "failed cmd 4" && exit 1
mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" || echo "failed cmd 5" && exit 1

mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;" || echo "failed cmd 6" && exit 1

kill $MYSQL_PID || echo "failed cmd exit" && exit 1

mysqld
