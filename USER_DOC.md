# User Documentation

## Services provided

- **NGINX** — reverse proxy, only entrypoint via port 443 (HTTPS)
- **WordPress** — the website and its admin panel
- **MariaDB** — the database storing WordPress data

## Start and stop

```bash
make        # start everything
make down   # stop everything
```

## Access the website

- Website: `https://login.42.fr`
- Admin panel: `https://login.42.fr/wp-admin`

> The browser will warn about the certificate — it is self-signed. Click "Advanced" then "Accept the Risk and Continue".

## Credentials
Credentials are stored locally in the `secrets/` folder (not in git):
This files must be presents and completed

`secrets/credentials.txt` -> WordPress admin and user login/password
`secrets/db_password.txt` -> MariaDB user password
`secrets/db_root_password.txt` -> MariaDB root password

## Check that services are running

```bash
docker ps
```

All three containers (`nginx`, `wordpress`, `mariadb`) should show `Up`.

To check logs:
```bash
docker logs nginx
docker logs wordpress
docker logs mariadb
```