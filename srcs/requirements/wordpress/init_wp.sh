#!/bin/bash

set -e

cd /var/www/html

wp core download --allow-root

chmod -R 777 /var/www/html

echo "Configuring PHP-FPM..."
sed -i 's/^listen = .*/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf
mv /home/my-config.php /var/www/html/wp-config.php

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F