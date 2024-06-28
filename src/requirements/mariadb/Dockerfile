FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install mariadb-server -y

RUN conf/50-server-cnf /etc/mysql/mariadb.conf.d/50-server.cnf