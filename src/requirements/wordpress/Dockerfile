FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt -y install wget php php-fpm php-mysql mariadb-client

RUN wget https://wordpress.org/wordpress-6.5.5.tar.gz -P /var/www
RUN cd /var/www && tar -xzf wordpress-6.5.5.tar.gz && rm wordpress-6.5.5.tar.gz

RUN chown -R root:root /var/www