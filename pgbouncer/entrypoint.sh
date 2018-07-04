#!/bin/sh

sed /pgbouncer.template.ini \
	-e "s/__POSTGRES_DB__/${POSTGRES_DB}/g" \
	-e "s/__POSTGRES_USER__/${POSTGRES_USER}/g" \
	-e "s/__POOLMODE__/${PGBOUNCER_POOLMODE}/g" \
	> /pgbouncer.ini

echo "'${POSTGRES_USER}' '${POSTGRES_PASSWORD}'" |
	tr "'" '"' > /pgbouncer_users.txt

pgbouncer /pgbouncer.ini
