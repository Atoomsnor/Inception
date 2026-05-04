all: env setup up

up:
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

re:
	docker compose -f srcs/docker-compose.yml down -v
	docker compose -f srcs/docker-compose.yml up --build

setup:
	mkdir -p /home/roversch/data/WordPress /home/roversch/data/mysql

env:
	cp ~/env_temp ./srcs/.env

start: up

stop: down

restart: down up

.PHONY: up down start stop restart
