FROM debian:bullseye

RUN apt-get update && apt-get install -y \
    mariadb-server \
    && rm -rf /var/lib/apt/lists/* \
    && rm -rf /var/lib/mysql/*

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY tools/mariadb.sh /mariadb.sh
RUN chmod +x /mariadb.sh

EXPOSE 3306

ENTRYPOINT ["/mariadb.sh"]