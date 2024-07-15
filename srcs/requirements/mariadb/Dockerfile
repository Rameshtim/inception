FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install curl mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
COPY conf/init.sql /etc/mysql/init.sql

RUN mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld
COPY conf/mariadb_script.sh .
RUN chmod +x mariadb_script.sh
# Set environment variables
# ENV MYSQL_ROOT_PASSWORD=example
# ENV MYSQL_DATABASE=mariadb
# ENV MYSQL_USER=root
# ENV MYSQL_PASSWORD=example

CMD [ "./mariadb_script.sh" ]