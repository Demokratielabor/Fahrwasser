FROM alpine:3.10

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

ENV LQFB_CORE_VERSION 3.2.2
ENV LQFB_PG_CONN "host=localhost dbname=liquid_feedback"

RUN apk add --no-cache \
		build-base \
		curl \
		libpq \
		postgresql-dev && \
	# install lqfb-core
	curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/backend/v${LQFB_CORE_VERSION}/liquid_feedback_core-v${LQFB_CORE_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION} && \
	make -j $(nproc) && \
	mkdir -p /opt/liquid_feedback_core && \
	cp lf_update lf_update_issue_order lf_update_suggestion_order /opt/liquid_feedback_core && \
	rm -rf /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION} && \
	# remove build-deps
	apk del --no-cache \
		build-base \
		curl \
		postgresql-dev

COPY entrypoint.sh /entrypoint.sh

CMD "/entrypoint.sh"
