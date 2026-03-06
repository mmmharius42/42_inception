# Developer Documentation

## Prerequisites

- Debian/Ubuntu VM with Docker and Docker Compose installed
- Git, Make

## Setup from scratch

**1. Clone the repo**
```bash
git clone https://github.com/login/42_inception.git
cd 42_inception
```

**2. Create the `.env` file**
```bash
cp srcs/.env.exemple srcs/.env
# Edit DOMAIN_NAME, MYSQL_DATABASE, MYSQL_USER
```

**3. Create the secret files**
```bash
# Use the exemple files as templates
cp secrets/credentials_exemple.txt secrets/credentials.txt
cp secrets/db_password_exemple.txt secrets/db_password.txt
cp secrets/db_root_password_exemple.txt secrets/db_root_password.txt
# Fill in real values (never commit these files)
```

**4. Configure the domain**
```bash
echo "127.0.0.1 login.42.fr" | sudo tee -a /etc/hosts
```

## Build and launch

```bash
make        # build images and start containers
make up     # build images and start containers
make down   # stop containers
make clean  # stop + remove volumes and images
make re     # full rebuild from scratch
```

## Useful commands

```bash
docker ps                          # list running containers
docker logs <container>            # view container logs
docker exec -it <container> bash   # open shell in container
docker volume ls                   # list volumes
```

## Data persistence

WordPress files and the database are stored in Docker named volumes:
- `srcs_wp_data` → WordPress files (`/var/www/html` in container)
- `srcs_db_data` → MariaDB data (`/var/lib/mysql` in container)

Volumes persist between `make down` / `make up`. Use `make clean` to wipe them.
