FROM debian:Bookworm

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
	build-essential \
	g++ \
	cmake \
	make \
	valgrind \
	gdb \
	git \
	vim \
	telnet \
	python3 \
	mariadb-server \
	&& rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace


#sudo mysql_secure_installation


EXPOSE 3306

COPY .bashrc /root/.bashrc

# Optional: Set up a build script
#RUN bash /root/bashrc


