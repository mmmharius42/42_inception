#!/bin/bash
mkdir -p /etc/nginx/ssl

if [ ! -f /etc/nginx/ssl/nginx.crt ]; then
    openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/nginx.key \
        -out /etc/nginx/ssl/nginx.crt \
        -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=student/CN=mpapin.42.fr"
fi

envsubst '${DOMAIN_NAME}' < /etc/nginx/sites-available/default > /etc/nginx/sites-enabled/default
exec nginx -g "daemon off;"