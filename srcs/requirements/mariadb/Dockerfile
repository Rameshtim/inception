FROM debian:bullseye
RUN apt update && apt upgrade -y
RUN apt install curl mariadb-server tini -y

COPY conf/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf


COPY tools/script.sh .
RUN chmod +x ./script.sh


ENTRYPOINT [ "tini", "--", "./script.sh" ]
