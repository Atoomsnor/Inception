all: env up


up:
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

re:
	docker compose -f srcs/docker-compose.yml down -v
	docker compose -f srcs/docker-compose.yml up --build

env:
	cp ~/Desktop/env_temp ./srcs/.env

start: up

stop: down

restart: down up

.PHONY: up down start stop restart
