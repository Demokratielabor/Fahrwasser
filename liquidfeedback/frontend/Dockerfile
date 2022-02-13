FROM debian:bullseye-slim AS base-builder

ENV LQFB_MOONBRIDGE_VERSION 1.1.2
ENV LQFB_WEBMCP_VERSION 2.2.0
ENV LQFB_ROCKETWIKI_VERSION 0.4
ENV LQFB_FRONTEND_VERSION 3.2.1

ENV LANG C.UTF-8

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
	ca-certificates \
	curl


FROM base-builder AS c-builder
RUN apt-get -y install --no-install-recommends build-essential


FROM c-builder AS lua-builder
RUN apt-get -y install --no-install-recommends \
	liblua5.3-dev \
	lua5.3


FROM lua-builder AS moonbridge-builder
RUN apt-get -y install --no-install-recommends \
	bmake \
	libbsd-dev \
	lsb-release
RUN curl -sSL http://www.public-software-group.org/pub/projects/moonbridge/v${LQFB_MOONBRIDGE_VERSION}/moonbridge-v${LQFB_MOONBRIDGE_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION} && \
	bmake MOONBR_LUA_PATH=/opt/moonbridge/?.lua && \
	mkdir -p /opt/moonbridge && \
	cp moonbridge moonbridge_http.lua /opt/moonbridge/


FROM lua-builder AS webmcp-builder
RUN apt-get -y install --no-install-recommends \
	patch \
	postgresql-server-dev-all
COPY patches/webmcp /patches
RUN curl -sSL http://www.public-software-group.org/pub/projects/webmcp/v${LQFB_WEBMCP_VERSION}/webmcp-v${LQFB_WEBMCP_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/webmcp-v${LQFB_WEBMCP_VERSION} && \
	patch -p1 < /patches/0001-use-lua5.3.patch && \
	make && \
	mkdir -p /opt/webmcp && \
	cp -RL framework/* /opt/webmcp/


FROM c-builder AS rocketwiki-builder
RUN apt-get -y install --no-install-recommends \
	ghc \
	libghc-parsec3-dev
RUN curl -sSL http://www.public-software-group.org/pub/projects/rocketwiki/liquid_feedback_edition/v${LQFB_ROCKETWIKI_VERSION}/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION} && \
	make && \
	mkdir -p /opt/rocketwiki-lqfb && \
	cp rocketwiki-lqfb rocketwiki-lqfb-compat /opt/rocketwiki-lqfb


FROM base-builder AS lqfb-frontend-builder
RUN apt-get -y install --no-install-recommends patch
COPY patches/lqfb-frontend /patches
RUN curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/frontend/v${LQFB_FRONTEND_VERSION}/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}.tar.gz | tar xzC /tmp && \
	mv /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION} /opt/liquid_feedback_frontend && \
	cd /opt/liquid_feedback_frontend && \
	/patches/apply.sh


FROM debian:bullseye-slim

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:2812/ || exit 1

VOLUME [ "/opt/liquid_feedback_frontend/config" ]

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
	ca-certificates \
	curl \
	libatomic1 \
	libbsd0 \
	liblua5.3 \
	libpq5 \
	imagemagick \
	msmtp-mta \
	python3-pip && \
	pip3 --no-cache-dir install markdown2 && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY --from=moonbridge-builder /opt/moonbridge /opt/moonbridge
COPY --from=webmcp-builder /opt/webmcp /opt/webmcp
COPY --from=rocketwiki-builder /opt/rocketwiki-lqfb /opt/rocketwiki-lqfb
COPY --from=lqfb-frontend-builder /opt/liquid_feedback_frontend /opt/liquid_feedback_frontend

COPY msmtprc.template /msmtprc.template
COPY init.template.lua /init.template.lua
COPY custom_config.lua /opt/liquid_feedback_frontend/config/custom_config.lua

COPY entrypoint.sh /entrypoint.sh

CMD "/entrypoint.sh"

EXPOSE 2812
