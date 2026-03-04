NAME        = inception
COMPOSE     = docker-compose -f srcs/docker-compose.yml

all: up

up:
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean

re: fclean all

.PHONY: all up down clean fclean re