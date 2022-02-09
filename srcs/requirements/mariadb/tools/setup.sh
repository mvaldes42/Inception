service mysql start
sleep 2
if mysql -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "use ${MYSQL_DATABASE_NAME}";
then
    echo "Database $MYSQL_DATABASE_NAME already exists. Proceed to next step."
else
    echo "Installing db ..."
    mysql_install_db > /dev/null 2>&1
    # service mysql start
    mysql -e "CREATE USER '${MYSQL_USER}'@'localhost' identified by '${MYSQL_PASSWORD}';"
	mysql -e "CREATE DATABASE IF NOT EXISTS ${MYSQL_DATABASE_NAME};"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
fi
service mysql stop 
sleep 5
echo "Launching mysqld"
mysqld_safe