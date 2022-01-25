# DOCKER TASKS

COMPOSE_FILE= srcs/docker-compose.yml

.PHONY: all hosts build up start down destroy stop restart ps

.SILENT: hosts

all: hosts build up

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
restart:
		docker-compose -f ${COMPOSE_FILE} stop $(c)
		docker-compose -f ${COMPOSE_FILE} up -d $(c)
ps:
		docker-compose -f ${COMPOSE_FILE} ps