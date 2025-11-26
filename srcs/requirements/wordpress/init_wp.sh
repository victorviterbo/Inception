#!/bin/bash

set -e

cd /var/www/html

if [ ! -f /var/www/html/wp-config.php ]; then

    wp core download --allow-root

    mv /home/my-config.php /var/www/html/wp-config.php

    wp core install --allow-root \
        --url='https://vviterbo.42.ch' \
        --title=${WP_TITLE} \
        --admin_user=${WP_USR} \
        --admin_password=${WP_PWD} \
        --admin_email=${WP_EMAIL} \
        --skip-email

    chmod -R 777 /var/www/html

    echo "Configuring PHP-FPM..."
fi

sed -i 's|^listen = #|listen = '"$WP_PORT"'|g' /etc/php/8.2/fpm/pool.d/www.conf

echo "Starting PHP-FPM..."

exec /usr/sbin/php-fpm8.2 -F || exit 1
