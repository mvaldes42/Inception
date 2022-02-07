FROM debian:buster

RUN apt-get update

RUN apt-get -y install php7.3 php-mysqli php-fpm mariadb-client sendmail
COPY ./www.conf /etc/php/7.3/fpm/pool.d

ADD https://wordpress.org/wordpress-5.7.2.tar.gz /var/www/ 
RUN cd /var/www && tar -xzvf wordpress-5.7.2.tar.gz && \
    rm -f /var/www/wordpress-5.7.2.tar.gz && \
    rm -f /var/www/wordpress/wp-config-sample.php

COPY ./wp-config.php ./var/www/wordpress/

ADD https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar /var/www
RUN cd /var/www && chmod +x wp-cli.phar && mv wp-cli.phar /usr/local/bin/wp

RUN mkdir ./run/php/
# CMD ./usr/sbin/php-fpm7.3 -F

COPY setup.sh /
RUN chmod 777 /setup.sh && sleep 5
ENTRYPOINT ["sh", "/setup.sh"]