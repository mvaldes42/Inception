COMPOSE_FILE= srcs/docker-compose.yml

.PHONY: all services-stop hosts build up start down destroy stop restart ps clean

.SILENT: hosts

all: hosts build up

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
		docker-compose -f ${COMPOSE_FILE} up -d --no-recreate --remove-orphans $(c)
start:
		docker-compose -f ${COMPOSE_FILE} start $(c)
down:
		docker-compose -f ${COMPOSE_FILE} down $(c)
destroy:
		docker-compose -f ${COMPOSE_FILE} down -v $(c)
stop:
		docker-compose -f ${COMPOSE_FILE} stop $(c)
restart: stop up
ps:
		docker-compose -f ${COMPOSE_FILE} ps
clean:
		sudo docker-compose -f srcs/docker-compose.yml down
		sudo docker rmi -f $$(sudo docker images -qa)
		sudo docker rm -f $$(sudo docker ps -qa)
		sudo docker rm -f $$(sudo docker ps -ls)
		sudo docker volume rm $$(sudo docker volume ls -q)
		sudo docker system prune -a --volumes
		sudo docker system prune -a --force
