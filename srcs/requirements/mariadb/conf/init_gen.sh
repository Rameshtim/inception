#!/bin/sh

WP_USER=$(cat /run/secrets/wp_admin_user)
WP_PASS=$(cat /run/secrets/wp_admin_pass)

cat <<EOF > /etc/mysql/init.sql
CREATE DATABASE IF NOT EXISTS wordpress;
CREATE USER IF NOT EXISTS '$WP_USER'@'%' IDENTIFIED BY '$WP_PASS';
GRANT ALL PRIVILEGES ON *.* TO '$WP_USER'@'%' WITH GRANT OPTION;
FLUSH PRIVILEGES;
EOF