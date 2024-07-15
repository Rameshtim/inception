FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install curl mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
COPY conf/init.sql /etc/mysql/init.sql

RUN mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld
COPY conf/mariadb_script.sh .
RUN chmod +x mariadb_script.sh

CMD [ "./mariadb_script.sh" ]