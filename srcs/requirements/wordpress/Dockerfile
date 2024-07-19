FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt -y install wget curl php php-fpm php-mysqli mariadb-client

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

COPY tools/script.sh .
RUN chmod +x script.sh
CMD [ "./script.sh" ]
# CMD [ "php-fpm7.4", "-F" ]