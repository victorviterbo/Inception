FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	php-fpm \
    php-redis \ 
    php-mysql \
	mariadb-client \
	curl \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /home

#sudo mysql_secure_installation

EXPOSE 9000
EXPOSE 3306

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN /usr/local/bin/wp --info

COPY ./wp-config.php /home/my_wp-config.php

COPY ./init_wp.sh /home/


CMD ["/home/init_wp.sh"]
