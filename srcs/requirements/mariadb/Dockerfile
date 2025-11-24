FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
    sudo \
    mariadb-server \
    mariadb-client

EXPOSE 3306

COPY ./init_db.sh /
RUN chmod +x /init_db.sh

COPY ./50-server.cnf /etc/mysql/mariadb.conf.d/

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

CMD ["bash", "/init_db.sh"]
