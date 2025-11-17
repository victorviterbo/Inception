#!/bin/bash

mkdir /var/www/
mkdir /var/www/html


rm -rf /var/www/html/*
cd /var/www/html


chmod +x /usr/local/bin/wp/wp-cli.phar 

wp core download --allow-root

#mv /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

#mv /wp-config.php /var/www/html/wp-config.php


sed -i -r "s/db1/$db_name/1"   wp-config.php
sed -i-r "s/user/$db_user/1"  wp-config.php
sed -i -r "s/pwd/$db_user_pwd/1"    wp-config.php

wp core install --url=$domain/ --title=$title --admin_user=$admin_id --admin_password=$admin_pw  --allow-root #--admin_email=$admin_email --skip-email


wp user create $user_id --role=author --user_pass=$user_pw --allow-root #$WP_EMAIL 


wp theme install astra --activate --allow-root

wp plugin install redis-cache --activate --allow-root

wp plugin update --all --allow-root
 
sed -i 's/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/g' /etc/php/7.3/fpm/pool.d/www.conf

mkdir /run/php

wp redis enable --allow-root

/usr/sbin/php-fpm7.3 -F