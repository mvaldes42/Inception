FROM debian:buster

RUN apt-get update && apt-get dist-upgrade -yq && apt-get install -yq nginx openssl

RUN apt-get clean && rm -rf /var/lib/apt/lists/

RUN mkdir /var/www/mvaldes.42.fr && \
chown -R www-data /var/www/* && \
chmod -R 755 /var/www/*

COPY tools/nginx.conf /etc/nginx/sites-available/mvaldes.42.fr
RUN ln -s /etc/nginx/sites-available/mvaldes.42.fr /etc/nginx/sites-enabled && \
rm /etc/nginx/sites-enabled/default

RUN mkdir /etc/nginx/ssl
RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes -out /etc/nginx/ssl/mvaldes.42.fr.crt \
-keyout /etc/nginx/ssl/mvaldes.42.fr.key -subj "/C=FR/ST=Paris/L=Paris/O=42/OU=mvaldes/CN=mvaldes.42.fr"

RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf

EXPOSE 443
CMD ["/usr/sbin/nginx"]