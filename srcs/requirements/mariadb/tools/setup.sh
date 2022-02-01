if [ ! -d "/var/lib/mysql/wordpress" ]; then 
    
    mysql_install_db
    # sudo chown -R mysql:mysql /var/run/mysqld/mysqld.sock
    # sudo chown -R mysql:mysql /var/run/mysqld/mysqld.pid
    service mysql start
    
    mysql -e "CREATE USER '${MYSQL_USER}'@'localhost' identified by '${MYSQL_PASSWORD}';"
	mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"
	mysql -e "GRANT ALL PRIVILEGES ON *.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
fi
mysqld