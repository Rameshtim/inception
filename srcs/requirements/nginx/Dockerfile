FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install -y nginx vim curl openssl wordpress
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=login.42.fr/UID=login"
RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY conf/index.html /var/www/html/index.html
COPY conf/index.php /var/www/html/index.php
COPY conf/calc.php /var/www/html/calc.php

CMD [ "nginx", "-g", "daemon off;" ]

# with nginx we will only access https://localhost or https://127.0.0.1/