#!/bin/bash

openssl req -x509 -newkey rsa:4096 -keyout /etc/ssl/private/nginx-selfsigned.key -out /etc/ssl/certs/nginx-selfsigned.crt -sha256 -days 3650 -nodes -subj "/C=CH/ST=Vaud/L=Lausanne/O=42/OU=42.student/CN=vviterbo.42.ch"

exec nginx -g "daemon off;"  || exit 1
