FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt -y install wget curl php php-fpm php-mysqli mariadb-client

# RUN wget https://wordpress.org/wordpress-6.5.5.tar.gz -P /var/www
# RUN cd /var/www && tar -xzf wordpress-6.5.5.tar.gz && rm wordpress-6.5.5.tar.gz
# RUN chown -R root:root /var/www
# Create the /run/php directory
RUN mkdir -p /run/php && chown -R www-data:www-data /run/php
COPY /conf/www.conf /etc/php/7.4/fpm/pool.d/.

COPY conf/script.sh .
RUN chmod +x script.sh
CMD [ "./script.sh" ]
# CMD [ "php-fpm7.4", "-F" ]