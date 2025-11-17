FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	php-fpm \
    php-redis \ 
    php-mysql \
	mariadb-client \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /home

#sudo mysql_secure_installation

EXPOSE 9000
EXPOSE 3306

COPY ./init_wp.sh /home/
COPY ./wp-cli.phar /usr/local/bin/wp/wp-cli.phar 

CMD ["/home/init_wp.sh"]
