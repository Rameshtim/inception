#!/bin/bash
DB_USER=$(cat /run/secrets/db_user)
DB_PASSWORD=$(cat /run/secrets/db_password)

sed -i "s/\${DB_USER}/$DB_USER/g" /etc/mysql/init.sql
sed -i "s/\${DB_PASSWORD}/$DB_PASSWORD/g" /etc/mysql/init.sql

mkdir -p /docker-entrypoint-initdb.d
cp /etc/mysql/init.sql /docker-entrypoint-initdb.d/init.sql

# Run the original entrypoint script
exec sql_init.sh "$@"