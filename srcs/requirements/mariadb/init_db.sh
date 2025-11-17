#!/bin/bash

service mysql start 

cat > init.sql << EOF
CREATE DATABASE IF NOT EXIST $MY_MARIADB;
CREATE USER IF NOT EXIST '$ADMIN_ID'@'%' IDENTIFIED BY '$ADMIN_PW';
CREATE USER IF NOT EXIST '$USER_ID'@'%' IDENTIFIED BY '$USER_PW';
GRANT ALL PRIVILEGES ON $MY_MARIADB TO '$ADMIN_ID'@'%';
FLUSH PRIVILEGES;
EOF

mysql < init.sql

kill $(cat /var/run/mysqld/mysqld.pid)

mysqld