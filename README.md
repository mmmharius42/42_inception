*This project has been created as part of the 42 curriculum by mpapin.*

# Inception

## Description

This project set up a small web infrastructure using Docker Compose inside a virtual machine. It consists of three services: NGINX (reverse proxy with TLSv1.2/1.3), WordPress + PHP-FPM, and MariaDB. Each service runs in its own container built from Debian Bullseye.

**Main design choices:**

- **Virtual Machines vs Docker** — A VM virtualizes hardware and runs a full OS. Docker virtualizes at the OS level, sharing the host kernel. Docker is lighter and faster to spin up, but less isolated than a VM.
- **Secrets vs Environment Variables** — Environment variables are visible to any process. Docker secrets are mounted as files in `/run/secrets`, accessible only to the container that needs them. Secrets are used here for passwords and credentials.
- **Docker Network vs Host Network** — Host network shares the host's network stack (no isolation). Docker bridge network creates an isolated internal network between containers. All containers here communicate through a custom bridge network called `inception`.
- **Docker Volumes vs Bind Mounts** — Bind mounts link a host directory directly into the container (forbidden by this project). Named volumes are managed by Docker and are more portable and secure.

## Instructions

### Prerequisites
- Docker and Docker Compose installed
- `login.42.fr` pointing to `127.0.0.1` in `/etc/hosts`
- Secret files created in `secrets/` (see `secrets/*_exemple.txt` for format)
- `.env` file created in `srcs/` (see `srcs/.env.exemple` for format)

### Run
```bash
make        # build and start
make down   # stop
make clean  # stop and remove volumes/images
make re     # full rebuild
```


### Access
- Website: `https://login.42.fr`
- Admin panel: `https://login.42.fr/wp-admin`

### Resources 
- [Docker official documentation](https://docs.docker.com/)
- [Docker Compose documentation](https://docs.docker.com/compose/)
- [NGINX documentation](https://nginx.org/en/docs/)
- [WordPress WP-CLI documentation](https://wp-cli.org/)
- [MariaDB documentation](https://mariadb.com/kb/en/)
- [PHP-FPM documentation](https://www.php.net/manual/en/install.fpm.php)
- [OpenSSL documentation](https://www.openssl.org/docs/)

### IA USAGE
AI was used to clarify Docker concepts and to proofread documentation. All code was written and validated personally.