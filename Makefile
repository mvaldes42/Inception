COMPOSE_FILE= srcs/docker-compose.yml

DB_DATA_DIR= /home/mvaldes/data/db_data
WP_DATA_DIR= /home/mvaldes/data/wordpress_data

.PHONY: all services-stop hosts build up start down destroy stop restart ps logs clean create-dirs remove-dirs

.SILENT: hosts create-dirs remove-dirs

all: hosts create-dirs services-stop build up

services-stop:
		sudo systemctl stop nginx
		sudo systemctl disable nginx
		sudo service nginx stop; sudo service mysql stop
hosts:
		if grep -R "mvaldes.42.fr" /etc/hosts > /dev/null; then \
			echo 'mvaldes.42.fr already in hosts'; \
		else \
			echo '127.0.0.1 mvaldes.42.fr' | sudo tee -a /etc/hosts > /dev/null; \
		fi
		if grep -R "www.mvaldes.42.fr" /etc/hosts > /dev/null; then \
			echo 'www.mvaldes.42.fr already in hosts'; \
		else \
			echo '127.0.0.1 www.mvaldes.42.fr' | sudo tee -a /etc/hosts > /dev/null; \
		fi
build: hosts
		docker-compose -f ${COMPOSE_FILE} build $(c)
up:
		docker-compose -f ${COMPOSE_FILE} up -d $(c)
start:
		docker-compose -f ${COMPOSE_FILE} start $(c)
down:
		docker-compose -f ${COMPOSE_FILE} down $(c)
destroy:
		docker-compose -f ${COMPOSE_FILE} down -v $(c)
stop:
		docker-compose -f ${COMPOSE_FILE} stop $(c)
restart: stop start
ps:
		docker-compose -f ${COMPOSE_FILE} ps
logs:
		docker logs -ft $(c)
clean: down remove-dirs
		echo "-- docker rmi -f $$(docker images -qa)"
		docker rmi -f $$(docker images -qa)
		echo "-- docker rm -f $$(docker ps -qa)"
		docker rm -f $$(docker ps -qa)
		echo "-- docker volume rm $$(docker volume ls -q)"
		docker volume rm $$(docker volume ls -q)
		echo "-- docker system prune -a --volumes"
		docker system prune -a --volumes
		echo "-- docker system prune -a --force"
		docker system prune -a --force

create-dirs:
		if [ -d "${DB_DATA_DIR}" ] ; then \
			echo "Directory ${DB_DATA_DIR} exists."; \
		else \
			sudo mkdir ${DB_DATA_DIR}; \
			echo "Directory ${DB_DATA_DIR} created."; \
		fi
		if [ -d "${WP_DATA_DIR}" ] ; then \
			echo "Directory ${WP_DATA_DIR} exists."; \
		else \
			sudo mkdir ${WP_DATA_DIR}; \
			echo "Directory ${WP_DATA_DIR} created."; \
		fi

remove-dirs:
	sudo rm -rf ${DB_DATA_DIR}
	echo "Directory ${DB_DATA_DIR} removed."
	sudo rm -rf ${WP_DATA_DIR}
	echo "Directory ${WP_DATA_DIR} removed."