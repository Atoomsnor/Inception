up:
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

start: up

stop: down

restart: down up

.PHONY: up down start stop restart
