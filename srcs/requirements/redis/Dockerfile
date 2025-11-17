FROM debian:bookworm

RUN apt-get update && apt-get install -y \
    redis-server \
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/lib/redis && \
    chown redis:redis /var/lib/redis

COPY redis.conf /home/redis.conf

EXPOSE 6379

CMD ["redis-server", "/home/redis.conf"]