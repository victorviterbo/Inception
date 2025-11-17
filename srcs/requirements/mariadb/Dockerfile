FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /home

#sudo mysql_secure_installation

EXPOSE 3306

COPY ./init_db.sh /home/
COPY ./server.cnf /etc/mysql/mariadb.conf.d/

CMD ["/home/init_db.sh"]

