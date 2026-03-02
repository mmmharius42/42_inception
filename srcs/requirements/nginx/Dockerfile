FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    nginx \
    openssl \
    && rm -rf /var/lib/apt/lists/*

COPY conf/nginx.conf /etc/nginx/sites-available/default
COPY tools/generate_ssl.sh /generate_ssl.sh
RUN chmod +x /generate_ssl.sh

EXPOSE 443

ENTRYPOINT ["/generate_ssl.sh"]