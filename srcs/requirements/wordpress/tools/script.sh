#!/bin/bash

cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

DB_USER=$(cat /run/secrets/db_user)
WP_USER=$(cat /run/secrets/wp_user)
WP_PASS=$(cat /run/secrets/wp_pass)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)

echo "WAITING FOR MARIADB ...."
sleep 10

./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=${MYSQL_DATABASE} --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root
./wp-cli.phar core install --url=localhost --title=inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
./wp-cli.phar user create $WP_USER wp_user@evaluator.com --role=subscriber --user_pass=$WP_PASS --allow-root

echo "FINISHING SETTING UP WORDPRESS...."
sleep 5
php-fpm7.4 -F
