#!/bin/bash

exec redis-server "/home/redis.conf --port ${REDIS_PORT} --requirepass ${REDIS_PASSWORD}"