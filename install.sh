#!/bin/bash
set -e

LOGIN="login"
DOMAIN_NAME="${LOGIN}.42.fr"
MYSQL_DATABASE="wordpress"
MYSQL_USER="wpuser"

DB_PASSWORD="mdp"
DB_ROOT_PASSWORD="mdp"

WP_ADMIN_USER="superuser"
WP_ADMIN_PASSWORD="mdp"
WP_ADMIN_EMAIL="admin@42.fr"
WP_USER="user"
WP_USER_PASSWORD="mdp"
WP_USER_EMAIL="user@42.fr"

REPO_URL="https://github.com/login/42_inception.git"

sudo apt-get update -qq
sudo apt-get install -y git make curl ca-certificates gnupg lsb-release > /dev/null

if ! command -v docker &> /dev/null; then
    sudo install -m 0755 -d /etc/apt/keyrings
    curl -fsSL https://download.docker.com/linux/debian/gpg | \
        sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
    sudo chmod a+r /etc/apt/keyrings/docker.gpg
    echo \
      "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] \
      https://download.docker.com/linux/debian $(lsb_release -cs) stable" | \
      sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update -qq
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin > /dev/null
    sudo systemctl enable docker
    sudo systemctl start docker
    sudo usermod -aG docker "$USER"
fi

REPO_DIR="$(basename "$REPO_URL" .git)"
if [ ! -d "$REPO_DIR" ]; then
    git clone "$REPO_URL"
fi
cd "$REPO_DIR"

cat > srcs/.env << EOF
DOMAIN_NAME=${DOMAIN_NAME}
LOGIN=${LOGIN}
MYSQL_DATABASE=${MYSQL_DATABASE}
MYSQL_USER=${MYSQL_USER}
EOF

echo -n "$DB_PASSWORD" > secrets/db_password.txt
echo -n "$DB_ROOT_PASSWORD" > secrets/db_root_password.txt
cat > secrets/credentials.txt << EOF
WP_ADMIN_USER=${WP_ADMIN_USER}
WP_ADMIN_PASSWORD=${WP_ADMIN_PASSWORD}
WP_ADMIN_EMAIL=${WP_ADMIN_EMAIL}
WP_USER=${WP_USER}
WP_USER_PASSWORD=${WP_USER_PASSWORD}
WP_USER_EMAIL=${WP_USER_EMAIL}
EOF
chmod 600 secrets/db_password.txt secrets/db_root_password.txt secrets/credentials.txt

if ! grep -q "$DOMAIN_NAME" /etc/hosts; then
    echo "127.0.0.1 ${DOMAIN_NAME}" | sudo tee -a /etc/hosts > /dev/null
fi

mkdir -p "/home/${LOGIN}/data/mariadb" "/home/${LOGIN}/data/wordpress"

if groups | grep -q docker; then
    make
else
    sudo make
fi