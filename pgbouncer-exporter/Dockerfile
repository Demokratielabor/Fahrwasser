FROM python:3.9-alpine

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:9127/metrics || exit 1

RUN apk add --no-cache --virtual .build-deps \
	build-base \
	postgresql-dev && \
	apk add --no-cache \
	curl \
	postgresql-libs && \
	pip install --no-cache-dir prometheus-pgbouncer-exporter && \
	apk del --no-cache .build-deps

COPY pgbouncer-exporter.yml /pgbouncer-exporter.yml

ENTRYPOINT ["pgbouncer-exporter"]
CMD ["--log-file", "stdout", "--log-level", "WARNING", "--config", "/pgbouncer-exporter.yml"]

EXPOSE 9127
