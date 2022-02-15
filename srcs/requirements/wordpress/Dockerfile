FROM debian:buster

RUN apt-get update && apt-get -y install php7.3 php-mysqli php-fpm mariadb-client sendmail
COPY ./tools/www.conf /etc/php/7.3/fpm/pool.d

# ADD https://wordpress.org/wordpress-5.7.2.tar.gz /var/www/ 
COPY ./tools/wordpress_download /var/www/
RUN cd /var/www && tar -xzvf wordpress_download && \
    rm -f /var/www/wordpress_download && \
    rm -f /var/www/wordpress/wp-config-sample.php

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /var/www
RUN cd /var/www && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir ./run/php/

COPY tools/setup.sh /
RUN chmod 777 /setup.sh
ENTRYPOINT ["sh", "/setup.sh"]