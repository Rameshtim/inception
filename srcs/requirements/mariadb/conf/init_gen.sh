#!/bin/sh

WP_USER=$(cat /run/secrets/wp_admin_user)
WP_PASS=$(cat /run/secrets/wp_admin_pass)
DB_ROOT_PASSWORD=$(cat /run/secrets/db_root_password)

sleep 5
echo "starting mariadb"
service mariadb start

mariadb -u root -p"$DB_ROOT_PASSWORD" <<-EOSQL
    CREATE DATABASE IF NOT EXISTS wordpress --allow-root;
    CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_PASS';
    GRANT ALL PRIVILEGES ON *.* TO '$WP_USER'@'%' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL
echo "created table stopping mariadb"
service mariadb stop
sleep 5
mysqld