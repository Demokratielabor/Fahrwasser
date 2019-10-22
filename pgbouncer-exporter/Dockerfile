FROM python:3.7-alpine

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:9127/metrics || exit 1

RUN apk add --no-cache \
		curl \
		gcc \
		musl-dev \
		postgresql-dev \
		postgresql-libs && \
	python3 -m pip install --no-cache-dir prometheus-pgbouncer-exporter && \
	apk del --no-cache \
		gcc \
		musl-dev \
		postgresql-dev

COPY pgbouncer-exporter.yml /pgbouncer-exporter.yml

ENTRYPOINT ["pgbouncer-exporter"]
CMD ["--log-file", "stdout", "--log-level", "WARNING", "--config", "/pgbouncer-exporter.yml"]

EXPOSE 9127
