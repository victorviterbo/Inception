FROM debian:bookworm

RUN apt-get update && apt-get install -y \
	build-essential \
	vim \
	nginx \
	&& rm -rf /var/lib/apt/lists/*

WORKDIR /home

EXPOSE 9000
EXPOSE 443
