NAME        = inception
COMPOSE     = docker-compose -f srcs/docker-compose.yml
LOGIN       := $(shell grep '^LOGIN=' srcs/.env | cut -d '=' -f2)

all: up

up:
	mkdir -p /home/$(LOGIN)/data/mariadb /home/$(LOGIN)/data/wordpress
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re