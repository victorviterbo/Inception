FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	openssl \
	nginx \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /home

EXPOSE 9000
EXPOSE 443

COPY ./init_nginx.sh /home/init_nginx.sh
RUN chmod +x /home/init_nginx.sh



CMD [ "/home/init_nginx.sh" ]