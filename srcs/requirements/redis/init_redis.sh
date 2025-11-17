#!/bin/bash

CMD_ARGS="/home/redis.conf --port ${REDIS_PORT} --requirepass ${REDIS_PASSWORD}"

exec redis-server $CMD_ARGS