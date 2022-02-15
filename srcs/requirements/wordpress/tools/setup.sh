while ! mysql -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD > /dev/null 2>&1; do echo "Waiting for db ..."; sleep 5; done
if  [ ! -f /var/www/wordpress/wp-config.php ]; then
    while  [ ! -f /var/www/wordpress/wp-config.php ]; do
        echo 'Setting up db for wordpress ...'
        wp core config --allow-root --dbname=$MYSQL_DATABASE_NAME --dbuser=$MYSQL_USER --dbpass=$MYSQL_PASSWORD --dbhost=mariadb:3306 --path='/var/www/wordpress'
    done
    echo "Database created"
    while ! wp core is-installed --allow-root --path='/var/www/wordpress'
    do
        echo "Installing wordpress ..."
        wp core install --allow-root --url='mvaldes.42.fr' --title='WordPress for Inception' --admin_user=$WP_LOGIN --admin_password=$WP_PASS  --admin_email="admin@admin.fr" --path='/var/www/wordpress'
    done
    echo "Wordpress installed, creating users etc"
    wp user create --allow-root $WPU_1LOGIN user2@user.com --user_pass=$WPU_1PASS --role=contributor --path='/var/www/wordpress'
    wp theme install --allow-root dark-mode --activate --path='/var/www/wordpress'
fi
echo 'Launch PHP'
php-fpm7.3 -F --nodaemonize