FROM debian:bookworm

RUN groupadd -r mysql && useradd -r -g mysql mysql

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
    mariadb-server \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/run/mysqld && \
    chown -R mysql:mysql /var/run/mysqld && \
    chmod 755 /var/run/mysqld

RUN mkdir -p /var/lib/mysql && \
    chown -R mysql:mysql /var/lib/mysql

WORKDIR /home

RUN mysql_install_db --user=mysql --datadir=/var/lib/mysql

COPY ./init_db.sh /home/
COPY ./server.cnf /etc/mysql/mariadb.conf.d/

RUN chmod +x /home/init_db.sh

#RUN sudo mysql_secure_installation

USER mysql

EXPOSE 3306

COPY ./init_db.sh /home/
COPY ./server.cnf /etc/mysql/mariadb.conf.d/


CMD ["/home/init_db.sh"]

