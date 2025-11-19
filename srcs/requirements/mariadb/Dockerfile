FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
    sudo \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql/*

EXPOSE 3306

COPY ./init_db.sh /

RUN chmod +x /init_db.sh

COPY ./server.cnf /etc/mysql/mariadb.conf.d/


CMD ["bash", "/init_db.sh"]

