FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	php-fpm \
    php-mysql \
	mariadb-client \
	curl \
	&& rm -rf /var/lib/apt/lists/*

EXPOSE 9000

RUN mkdir -p /var/www/html
WORKDIR /var/www/html

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp
RUN /usr/local/bin/wp --info

COPY ./init_wp.sh /home/
RUN chmod +x /home/init_wp.sh

COPY wp-config.php /home/my-config.php

CMD ["/home/init_wp.sh"]