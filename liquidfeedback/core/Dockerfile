FROM alpine:latest

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

ENV LQFB_CORE_VERSION 3.2.2
ENV LQFB_PG_CONN "host=localhost dbname=liquid_feedback"

RUN apk add --no-cache \
		build-base \
		curl \
		postgresql-dev && \
	curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/backend/v${LQFB_CORE_VERSION}/liquid_feedback_core-v${LQFB_CORE_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION} && \
	make -j $(nproc) && \
	mkdir -p /opt/liquid_feedback_core && \
	cp lf_update lf_update_issue_order lf_update_suggestion_order /opt/liquid_feedback_core && \
	rm -rf /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION} && \
	apk del --no-cache \
		build-base \
		curl


COPY start.sh /
CMD "/start.sh"