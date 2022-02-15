service mysql start
echo 'testing if database exists'
if mysql -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "use ${MYSQL_DATABASE_NAME}";
then
    echo "Database $MYSQL_DATABASE_NAME already exists. Proceed to next step."
else
    echo "Installing db ..."
    mysql_install_db > /dev/null 2>&1
    mysql -e "CREATE USER '${MYSQL_USER}'@'%' identified by '${MYSQL_PASSWORD}';\
    CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_NAME};\
    GRANT ALL PRIVILEGES ON ${MYSQL_DATABASE_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';\
    ALTER USER 'root'@'localhost' IDENTIFIED BY '12345'; FLUSH PRIVILEGES;"
    echo 'Db configured'
fi
mysqladmin -uroot -p${MYSQL_ROOT_PASS} shutdown
echo "Launching mysqld"
mysqld