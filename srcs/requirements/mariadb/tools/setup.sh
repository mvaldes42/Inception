if [ ! -d "/var/lib/mysql/wordpress" ]; then
    echo "install db"
    mysql_install_db
    service mysql start
    mysql -e "CREATE USER '${MYSQL_USER}'@'localhost' identified by '${MYSQL_PASSWORD}';"
	mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
    service mysql stop 
fi
sleep 5
echo "launch mysqld"
mysqld