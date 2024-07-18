#!/bin/bash
mkdir -p /var/www/html
cd /var/www/html
curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

chmod +x wp-cli.phar

DB_USER=$(cat /run/secrets/db_user)
DB_PASS=$(cat /run/secrets/db_password)
WP_ADMIN_USER=$(cat /run/secrets/wp_admin_user)
WP_ADMIN_PASS=$(cat /run/secrets/wp_admin_pass)
WP_ADMIN_EMAIL=$(cat /run/secrets/wp_admin_email)

echo "WAITING FOR MARIADB ...."
sleep 10
./wp-cli.phar core download --allow-root
./wp-cli.phar config create --dbname=newwordpress --dbuser=$DB_USER --dbpass=$DB_PASS --dbhost=mariadb --allow-root
./wp-cli.phar core install --url=localhost --title=inception --admin_user=$WP_ADMIN_USER --admin_password=$WP_ADMIN_PASS --admin_email=$WP_ADMIN_EMAIL --allow-root
./wp-cli.phar plugin install --activate --path='/var/www/html' jetpack --allow-root
./wp-cli.phar theme install twentytwenty --activate --path='/var/www/html' --allow-root
echo "FINISHING SETTING UP WORDPRESS...."
sleep 5
php-fpm7.4 -F