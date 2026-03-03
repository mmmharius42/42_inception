#!/bin/bash

DB_PASSWORD=$(cat /run/secrets/db_password)
WP_ADMIN_USER=$(grep "^WP_ADMIN_USER=" /run/secrets/credentials | cut -d= -f2)
WP_ADMIN_PASSWORD=$(grep "^WP_ADMIN_PASSWORD=" /run/secrets/credentials | cut -d= -f2)
WP_ADMIN_EMAIL=$(grep "^WP_ADMIN_EMAIL=" /run/secrets/credentials | cut -d= -f2)
WP_USER=$(grep "^WP_USER=" /run/secrets/credentials | cut -d= -f2)
WP_USER_PASSWORD=$(grep "^WP_USER_PASSWORD=" /run/secrets/credentials | cut -d= -f2)
WP_USER_EMAIL=$(grep "^WP_USER_EMAIL=" /run/secrets/credentials | cut -d= -f2)

sed -i 's|listen = /run/php/php7.4-fpm.sock|listen = 9000|' \
    /etc/php/7.4/fpm/pool.d/www.conf

mkdir -p /run/php

mkdir -p /var/www/html
cd /var/www/html

if [ ! -f wp-config.php ]; then

    while ! php -r "
        \$conn = @mysqli_connect('mariadb', '${MYSQL_USER}', '${DB_PASSWORD}', '${MYSQL_DATABASE}');
        if (\$conn) { mysqli_close(\$conn); exit(0); } exit(1);
    " 2>/dev/null; do
        echo "Waiting for MariaDB..."
        sleep 2
    done

    echo "MariaDB is ready!"

    wp core download --allow-root --locale=en_US

    wp config create \
        --dbname="${MYSQL_DATABASE}" \
        --dbuser="${MYSQL_USER}" \
        --dbpass="${DB_PASSWORD}" \
        --dbhost=mariadb \
        --allow-root

    wp core install \
        --url="https://${DOMAIN_NAME}" \
        --title="Inception" \
        --admin_user="${WP_ADMIN_USER}" \
        --admin_password="${WP_ADMIN_PASSWORD}" \
        --admin_email="${WP_ADMIN_EMAIL}" \
        --skip-email \
        --allow-root

    wp user create "${WP_USER}" "${WP_USER_EMAIL}" \
        --user_pass="${WP_USER_PASSWORD}" \
        --role=author \
        --allow-root

    echo "WordPress installed!"
fi

exec php-fpm7.4 -F