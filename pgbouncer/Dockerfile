FROM alpine:3.13

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD pg_isready -h localhost -p 5432

RUN adduser -D pgbouncer && apk add --no-cache \
	pgbouncer \
	postgresql-client

COPY pgbouncer.template.ini /pgbouncer.template.ini
COPY entrypoint.sh /entrypoint.sh


CMD "/entrypoint.sh"

# use default postgres port for enhanced compatibility
EXPOSE 5432
