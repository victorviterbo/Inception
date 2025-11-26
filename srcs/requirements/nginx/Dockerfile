FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	openssl=3.0.17-1~deb12u3 \
	nginx=1.22.1-9+deb12u3

COPY ./init_nginx.sh /home/init_nginx.sh

COPY ./nginx.conf /etc/nginx/conf.d/nginx.conf

RUN chmod +x /home/init_nginx.sh

CMD [ "/home/init_nginx.sh" ]