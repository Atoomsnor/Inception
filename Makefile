all: env setup up

all: setup up

up:
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

re:
	docker compose -f srcs/docker-compose.yml down -v
	docker compose -f srcs/docker-compose.yml up --build

setup:
	mkdir -p /home/roversch/data/wordpress /home/roversch/data/mysql

env:
	cp ~/Desktop/env_test ./srcs/.env

clean:
	docker compose -f srcs/docker-compose.yml down -v

fclean: down
	rm -rf /home/roversch/data/wordpress/*

start: up

stop: down

restart: down up

.PHONY: up down start stop restart clean
