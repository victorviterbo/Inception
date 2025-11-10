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
	nginx \
	&& rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /workspace

EXPOSE 9000
EXPOSE 443

COPY .bashrc /root/.bashrc

# Optional: Set up a build script
#RUN bash /root/bashrc


