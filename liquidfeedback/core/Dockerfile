FROM alpine:latest

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

ENV LQFB_PG_CONN "host=localhost dbname=liquid_feedback"
ENV LQFB_CORE_VERSION 3.2.2

RUN apk add --no-cache \
		build-base \
		curl \
		postgresql-dev

# install core
RUN curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/backend/v${LQFB_CORE_VERSION}/liquid_feedback_core-v${LQFB_CORE_VERSION}.tar.gz | tar xzC /tmp
WORKDIR /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION}
RUN make
RUN mkdir -p /opt/liquid_feedback_core
RUN cp lf_update lf_update_issue_order lf_update_suggestion_order /opt/liquid_feedback_core

# remove packages only needed for build
RUN apk del --no-cache \
		build-base \
		curl


WORKDIR /
COPY start.sh .
CMD "/start.sh"
