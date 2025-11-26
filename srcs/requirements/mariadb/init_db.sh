#!/bin/bash

set -e

sed -i 's|port                    = ####|port                    = '"${MYSQL_PORT}"'|1' /etc/mysql/mariadb.conf.d/50-server.cnf

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

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';"
mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "FLUSH PRIVILEGES;"

mariadb -h localhost -u root -p"${MYSQL_ROOT_PASSWORD}" -e "SHOW DATABASES;"

kill $MYSQL_PID

mysqld || exit 1
