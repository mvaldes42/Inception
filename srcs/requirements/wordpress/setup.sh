# sleep 10
# echo "sleep 10"
while ! wp core is-installed --allow-root --path='/var/www/wordpress'
do
    echo "try"
    wp core install --allow-root --url='mvaldes.42.fr' --title='WordPress for Inception' --admin_user=$WP_LOGIN --admin_password=$WP_PASS  --admin_email="admin@admin.fr" --path='/var/www/wordpress'
    # sleep 3
done
echo "done"
wp user create --allow-root $WPU_1LOGIN user2@user.com --user_pass=$WPU_1PASS --role=author --path='/var/www/wordpress'
wp theme install --allow-root dark-mode --activate --path='/var/www/wordpress'
php-fpm7.3 -F --nodaemonize