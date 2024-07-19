FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install curl mariadb-server -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


COPY tools/script.sh .


ENTRYPOINT [ "bash", "./script.sh" ]
