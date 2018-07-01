FROM debian:stretch

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:2812/ || exit 1

ENV LQFB_MOONBRIDGE_VERSION 1.0.2
ENV LQFB_WEBMCP_VERSION 2.1.0
ENV LQFB_FRONTEND_VERSION 3.2.1

ENV LANG C.UTF-8

VOLUME [ "/opt/liquid_feedback_frontend/config" ]

RUN apt-get update && \
	apt-get -y install --no-install-recommends \
		curl \
		build-essential \
		bmake \
		lsb-release \
		lua5.3 \
		liblua5.3-dev \
		postgresql-server-dev-all \
		libbsd-dev \
		imagemagick \
		# ssmtp \
		python3-setuptools \
		python3-pip && \
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

RUN curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/frontend/v${LQFB_FRONTEND_VERSION}/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}.tar.gz | tar xzC /tmp && \
	cp -a /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION} /opt/liquid_feedback_frontend

RUN apt-get -y purge \
		build-essential \
		bmake \
		lsb-release && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

COPY init.lua /opt/liquid_feedback_frontend/config/init.lua
COPY config.lua /opt/liquid_feedback_frontend/config/config.lua

CMD [ "/opt/moonbridge/moonbridge", "/opt/webmcp/bin/mcp.lua", "/opt/webmcp/", "/opt/liquid_feedback_frontend/", "main", "config" ]

EXPOSE 2812
