#!/bin/bash

set -e

mysqld --datadir='/var/lib/mysql' &

MYSQL_PID=$!
echo MYSQL_PID

echo $MYSQL_PID

for i in {30..0}; do
    if mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SELECT 1" &> /dev/null; then
        echo "MariaDB is up and running!"
        break
    fi
    echo "MariaDB unavailable, retrying in 1 second ($i attempts left)..."
    sleep 1
done

if [ "$i" = 0 ]; then
    echo "MariaDB startup timeout. Exiting."
    exit 1
fi

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;" || (echo "failed cmd 1" && exit 1)

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';" || (echo "failed cmd 2" && exit 1)
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';" || (echo "failed cmd 3" && exit 1)
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';" || (echo "failed cmd 4" && exit 1)
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;" || (echo "failed cmd 5" && exit 1)

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;" || (echo "failed cmd 6" && exit 1)

kill $MYSQL_PID || (echo "failed cmd exit" && exit 1)

mysqld
