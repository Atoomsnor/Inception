################################################################################
# SSL                                                                          #
################################################################################

SSL_KEY = srcs/secrets/nginx.key
SSL_CRT = srcs/secrets/nginx.crt

################################################################################
# Build                                                                        #
################################################################################

all: env setup up

env:
	cp ~/Desktop/env_test ./srcs/.env

setup:
	mkdir -p /home/roversch/data/wordpress /home/roversch/data/mysql
	@if [ ! -f $(SSL_CRT) ]; then $(MAKE) generate_key; fi

generate_key:
	@echo "\033[0;32mGenerating key...\033[0m"
	@sleep 1
	@mkdir -p srcs/secrets
	@openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
		-keyout $(SSL_KEY) \
		-out $(SSL_CRT) \
		-subj "/CN=roversch.42.fr" 2>/dev/null

################################################################################
# Docker                                                                       #
################################################################################

up:
	docker compose -f srcs/docker-compose.yml up --build

down:
	docker compose -f srcs/docker-compose.yml down

clean:
	docker compose -f srcs/docker-compose.yml down -v

re: clean all

fclean: clean
# 	sudo rm -rf /home/roversch/data/wordpress/*
# 	sudo rm -rf /home/roversch/data/mysql/*
	rm -f $(SSL_KEY) $(SSL_CRT)

restart: down up

.PHONY: all env setup generate_key up down clean re fclean restart
