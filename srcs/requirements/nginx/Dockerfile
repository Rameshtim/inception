FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install -y nginx curl openssl wordpress tini
RUN mkdir -p /etc/nginx/ssl
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Paris/O=42/OU=42/CN=rtimsina.42.fr/UID=rtimsina"
RUN openssl req -x509 -nodes -out /etc/nginx/ssl/localhost.crt -keyout /etc/nginx/ssl/localhost.key -subj "/C=DE/ST=BLN/L=Berlin/O=42/OU=42/CN=localhost"
RUN mkdir -p /var/run/nginx
RUN chmod 755 /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY conf/nginx.conf /etc/nginx/nginx.conf
COPY pages/index.html /var/www/html/index.html
COPY pages/calc.php /var/www/html/calc.php

CMD [ "tini", "--", "nginx", "-g", "daemon off;" ]

# with nginx we will only access https://localhost or https://127.0.0.1/