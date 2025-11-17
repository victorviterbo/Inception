#!/bin/bash


if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing MariaDB data directory..."
    mysql_install_db --user=mysql --datadir=/var/lib/mysql
fi

# Start MariaDB safely

service mariadb start

#until service mariadb status; do
#    echo "Waiting for MariaDB init ..."
#done


#echo "CREATE DATABASE IF NOT EXIST ${MYSQL_DATABASE};" > /home/init.sql
#echo "CREATE USER IF NOT EXIST '$ADMIN_ID'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';" >> /home/init.sql
#echo "CREATE USER IF NOT EXIST '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD';" >> /home/init.sql
#echo "GRANT ALL PRIVILEGES ON $MYSQL_DATABASE TO '$ADMIN_ID'@'%';" >> /home/init.sql
#echo "FLUSH PRIVILEGES;" >> /home/init.sql

mariadb -u root -e "CREATE DATABASE IF NOT EXIST ${MYSQL_DATABASE};
CREATE USER IF NOT EXIST ${ADMIN_ID} IDENTIFIED BY ${MYSQL_ROOT_PASSWORD};
CREATE USER IF NOT EXIST ${MYSQL_USER} IDENTIFIED BY ${MYSQL_PASSWORD};

kill $(cat /var/run/mysqld/mysqld.pid)

echo "Starting MariaDB..."

service mariadb start