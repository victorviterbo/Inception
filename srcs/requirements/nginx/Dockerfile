FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	openssl \
	nginx

EXPOSE 9000
EXPOSE 443

COPY ./init_nginx.sh /home/init_nginx.sh

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

RUN chmod +x /home/init_nginx.sh

CMD [ "/home/init_nginx.sh" ]