#!/bin/bash

mkdir /var/www/
mkdir /var/www/html

rm -rf /var/www/html/*
cd /var/www/html


/usr/local/bin/wp core download --allow-root
mv /home/my_wp-config.php /var/www/html/wp-config.php

/usr/local/bin/wp core install --url=$DOMAIN/ --title=$TITLE --admin_user=$ADMIN_ID --admin_password=$MYSQL_ROOT_PASSWORD  --allow-root

/usr/local/bin/wp user create $MYSQL_USER --role=author --user_pass=$MYSQL_PASSWORD --allow-root


/usr/local/bin/wp plugin install redis-cache --activate --allow-root

/usr/local/bin/wp plugin update --all --allow-root
 
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php

/usr/local/bin/wp redis enable --allow-root
until mysql -h mariadb -u $DB_USER -p$DB_PASSWORD -e 'SELECT 1'; do
  echo 'Waiting for database...'
  sleep 3
done


/usr/sbin/php-fpm7.3 -F