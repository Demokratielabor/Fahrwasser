FROM alpine:3.19 AS builder

ENV LQFB_CORE_VERSION 3.2.2

RUN apk add --no-cache \
	build-base \
	curl \
	postgresql-dev && \
	# install lqfb-core
	curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/backend/v${LQFB_CORE_VERSION}/liquid_feedback_core-v${LQFB_CORE_VERSION}.tar.gz | tar xzC /tmp && \
	ln -s /tmp/liquid_feedback_core-v${LQFB_CORE_VERSION} /tmp/liquid_feedback_core && \
	cd /tmp/liquid_feedback_core && \
	make


FROM alpine:3.19

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

RUN apk add --no-cache postgresql-libs

COPY --from=builder /tmp/liquid_feedback_core/lf_update /opt/liquid_feedback_core/lf_update
COPY --from=builder /tmp/liquid_feedback_core/lf_update_issue_order /opt/liquid_feedback_core/lf_update_issue_order
COPY --from=builder /tmp/liquid_feedback_core/lf_update_suggestion_order /opt/liquid_feedback_core/lf_update_suggestion_order

COPY entrypoint.sh /entrypoint.sh

CMD "/entrypoint.sh"
