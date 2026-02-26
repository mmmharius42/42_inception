test-mariadb:
	docker rm -f mariadb 2>/dev/null || true
	docker build -t mariadb srcs/requirements/mariadb/
	docker run -d \
		--name mariadb \
		-e MYSQL_DATABASE=wordpress \
		-e MYSQL_USER=wpuser \
		-v $(PWD)/secrets/db_password:/run/secrets/db_password \
		-v $(PWD)/secrets/db_root_password:/run/secrets/db_root_password \
		mariadb
	sleep 10
	docker logs mariadb

stop-mariadb:
	docker rm -f mariadb