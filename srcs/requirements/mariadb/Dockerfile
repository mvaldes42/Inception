FROM debian:buster 

RUN apt-get update
RUN apt-get install -y mariadb-server sudo; 

COPY tools/setup.sh . 
RUN chmod +x setup.sh 

EXPOSE 3306

RUN rm /etc/mysql/mariadb.conf.d/50-server.cnf 
COPY tools/50-server.cnf /etc/mysql/mariadb.conf.d 
ENTRYPOINT ["sh", "/setup.sh"]