#!/bin/bash

set -e  # Exit on any error

#mkdir -p /var/www/html
cd /var/www/html

: << 'COMMENT'

# Wait for MariaDB to be ready
echo "Waiting for MariaDB to be ready..."
for i in {1..30}; do
    if mariadb -h mariadb -u"${MARIADB_USER}" -p"${MARIADB_PASSWORD}" -e "'SELECT 1'" >/dev/null 2>&1; then
        echo "MariaDB is ready!"
        break
    fi
    echo "MariaDB is not ready yet... attempt $i/30"
    sleep 3
done

# Final check
if ! mysql -h mariadb -u"${MARIADB_USER}" -p"${MARIADB_PASSWORD}" -e "SELECT 1" >/dev/null 2>&1; then
    echo "ERROR: Could not connect to MariaDB after 90 seconds"
    exit 1
fi

echo "Database is ready!"

echo "Downloading WordPress..."
if [ ! -f "wp-config.php" ]; then
    /usr/local/bin/wp dd || true
fi

if [ ! -f "wp-config.php" ]; then
    echo "Creating wp-config.php with WP-CLI..."
    # Let WP-CLI create the config file to ensure proper database connection
    /usr/local/bin/wp config create \
        --dbname=${MARIADB_DATABASE} \
        --dbuser=${MARIADB_USER} \
        --dbpass=${MARIADB_PASSWORD} \
        --dbhost=${MARIADB_HOST} \
        --allow-root
fi

if ! /usr/local/bin/wp core is-installed --allow-root 2>/dev/null; then
    echo "Installing WordPress..."
    /usr/local/bin/wp core install \
        --url=${DOMAIN} \
        --title="${WP_TITLE}" \
        --admin_user=${WP_ADMIN_USR} \
        --admin_password=${WP_ADMIN_PWD} \
        --admin_email=${WP_ADMIN_EMAIL} \
        --allow-root

    echo "Creating additional user..."
    /usr/local/bin/wp user create ${WP_USR} \
        ${WP_EMAIL} \
        --role=author \
        --user_pass=${WP_PWD} \
        --allow-root || true
    echo "Creating wp-config.php with WP-CLI..."
        # Let WP-CLI create the config file to ensure proper database connection
        /usr/local/bin/wp config create \
            --dbname=${MARIADB_DATABASE} \
            --dbuser=${MARIADB_USER} \
            --dbpass=${MARIADB_PASSWORD} \
            --dbhost=mariadb \
            --allow-root
    echo "Installing and activating Redis cache..."
    /usr/local/bin/wp plugin install redis-cache --activate --allow-root
    /usr/local/bin/wp plugin update --all --allow-root
fi

COMMENT

chmod -R 777 /var/www/html

ls /etc/php/
ls /etc/php/8.2
ls /etc/php/8.2/fpm
ls /etc/php/8.2/fpm/pool.d

echo "Configuring PHP-FPM..."
sed -i 's/^listen = .*/listen = 9000/g' /etc/php/8.2/fpm/pool.d/www.conf
mv /home/my-config.php /var/www/html/wp-config.php
cat /var/www/html/wp-config.php
if /usr/local/bin/wp plugin is-installed redis-cache --allow-root 2>/dev/null; then
    echo "Enabling Redis..."
    /usr/local/bin/wp redis enable --allow-root || true
fi

echo "Starting PHP-FPM..."
exec /usr/sbin/php-fpm8.2 -F