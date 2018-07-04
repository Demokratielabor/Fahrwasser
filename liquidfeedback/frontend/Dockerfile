FROM debian:stretch

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:2812/ || exit 1

ENV LQFB_MOONBRIDGE_VERSION 1.0.2
ENV LQFB_WEBMCP_VERSION 2.1.0
ENV LQFB_ROCKETWIKI_VERSION 0.4
ENV LQFB_FRONTEND_VERSION 3.2.1

ENV LANG C.UTF-8

VOLUME [ "/opt/liquid_feedback_frontend/config" ]

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		bmake \
		build-essential \
		curl \
		ghc \
		imagemagick \
		libbsd-dev \
		libghc-parsec3-dev \
		liblua5.3-dev \
		lsb-release \
		lua5.3 \
		postgresql-server-dev-all \
		python3-pip \
		python3-setuptools \
		rsync && \
	pip3 --no-cache-dir install markdown2

RUN curl -sSL http://www.public-software-group.org/pub/projects/moonbridge/v${LQFB_MOONBRIDGE_VERSION}/moonbridge-v${LQFB_MOONBRIDGE_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION} && \
	bmake -j $(nproc) MOONBR_LUA_PATH=/opt/moonbridge/?.lua && \
	mkdir -p /opt/moonbridge && \
	cp moonbridge moonbridge_http.lua /opt/moonbridge/ && \
	rm -rf /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION}

RUN curl -sSL http://www.public-software-group.org/pub/projects/webmcp/v${LQFB_WEBMCP_VERSION}/webmcp-v${LQFB_WEBMCP_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/webmcp-v${LQFB_WEBMCP_VERSION} && \
	sed -i Makefile.options \
		-e "s,LUA_BIN = lua,LUA_BIN = lua5.3," \
		-e "s,LUAC_BIN = luac,LUAC_BIN = luac5.3," \
		-e "s,5.2,5.3," \
		-e "s,52,53," && \
	make && \
	mkdir -p /opt/webmcp && \
	cp -RL framework/* /opt/webmcp/ && \
	rm -rf /tmp/webmcp-v${LQFB_WEBMCP_VERSION}

RUN curl -sSL http://www.public-software-group.org/pub/projects/rocketwiki/liquid_feedback_edition/v${LQFB_ROCKETWIKI_VERSION}/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION} && \
	make && \
	mkdir -p /opt/rocketwiki-lqfb && \
	cp rocketwiki-lqfb rocketwiki-lqfb-compat /opt/rocketwiki-lqfb && \
	rm -rf /tmp/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION}

RUN curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/frontend/v${LQFB_FRONTEND_VERSION}/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}.tar.gz | tar xzC /tmp && \
	rsync -a /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}/ /opt/liquid_feedback_frontend/. && \
	rm -rf /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}}

RUN apt-get -y purge \
		build-essential \
		bmake \
		ghc \
		lsb-release \
		rsync && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY init.template.lua /init.template.lua
COPY custom_config.lua /opt/liquid_feedback_frontend/config/custom_config.lua

COPY entrypoint.sh /entrypoint.sh

CMD "/entrypoint.sh"

EXPOSE 2812
