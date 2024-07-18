FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install curl mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/.
# COPY conf/init.sql /etc/mysql/init.sql

# COPY conf/init_gen.sh /docker-entrypoint-initdb.d/
COPY conf/init_gen.sh .
RUN chmod +x init_gen.sh


# RUN mkdir -p /var/lib/mysql /run/mysqld && chown -R mysql:mysql /var/lib/mysql /run/mysqld
# COPY conf/mariadb_script.sh .
# RUN chmod +x mariadb_script.sh

CMD [ "./init_gen.sh" ]