NAME        = inception
COMPOSE     = docker-compose -f srcs/docker-compose.yml
DATA_DB     = /home/mpapin/data/db
DATA_WP     = /home/mpapin/data/wordpress

all: up

up:
	@sudo mkdir -p $(DATA_DB) $(DATA_WP)
	$(COMPOSE) up --build -d

down:
	$(COMPOSE) down

clean:
	$(COMPOSE) down -v --rmi all

fclean: clean
	@sudo rm -rf $(DATA_DB) $(DATA_WP)

re: fclean all

.PHONY: all up down clean fclean re