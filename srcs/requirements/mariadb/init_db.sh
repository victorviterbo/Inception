#!/bin/bash

set -e

if [ -z "$(ls -A /var/lib/mysql)" ]; then

    mysql_install_db --datadir='/var/lib/mysql' 

    mysqld_safe --datadir='/var/lib/mysql' &

    MYSQL_PID=$!

    mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
    mariadb -u root -p${MYSQL_ROOT_PASSWORD} -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
    mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
    mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
    mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

    mariadb -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"

    kill $MYSQL_PID

fi

mysqld_safe --datadir=/var/lib/mysql
