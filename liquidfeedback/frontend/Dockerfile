FROM debian:stretch

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:2812/ || exit 1

ENV LQFB_MOONBRIDGE_VERSION 1.0.2
ENV LQFB_WEBMCP_VERSION 2.1.0
ENV LQFB_FRONTEND_VERSION 3.2.1

ENV LANG C.UTF-8

RUN apt-get update && \
	apt-get -y install \
		curl \
		build-essential \
		bmake \
		lsb-release \
		lua5.3 \
		liblua5.3-dev \
		postgresql-server-dev-all \
		libbsd-dev \
		imagemagick \
		ssmtp \
		python3-pip && \
	pip3 install markdown2

# install moonbridge
RUN curl -sSL http://www.public-software-group.org/pub/projects/moonbridge/v${LQFB_MOONBRIDGE_VERSION}/moonbridge-v${LQFB_MOONBRIDGE_VERSION}.tar.gz | tar xzC /tmp
WORKDIR /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION}
RUN bmake MOONBR_LUA_PATH=/opt/moonbridge/?.lua && \
	mkdir /opt/moonbridge && \
	cp moonbridge moonbridge_http.lua /opt/moonbridge/

# install webmcp
RUN curl -sSL http://www.public-software-group.org/pub/projects/webmcp/v${LQFB_WEBMCP_VERSION}/webmcp-v${LQFB_WEBMCP_VERSION}.tar.gz | tar xzC /tmp
WORKDIR /tmp/webmcp-v${LQFB_WEBMCP_VERSION}
RUN sed -i Makefile.options \
		-e "s,LUA_BIN = lua,LUA_BIN = lua5.3," \
		-e "s,LUAC_BIN = luac,LUAC_BIN = luac5.3," \
		-e "s,5.2,5.3," \
		-e "s,52,53," && \
	make && \
	mkdir /opt/webmcp && \
	cp -RL framework/* /opt/webmcp/

# install frontend
RUN curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/frontend/v${LQFB_FRONTEND_VERSION}/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}.tar.gz | tar xzC /tmp
RUN mv /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION} /opt/liquid_feedback_frontend
COPY config.lua /opt/liquid_feedback_frontend/config/custom.lua

# remove packages only needed for build
RUN apt-get -y purge \
		build-essential \
		bmake \
		lsb-release && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*


WORKDIR /
CMD [ "/opt/moonbridge/moonbridge", "/opt/webmcp/bin/mcp.lua", "/opt/webmcp/", "/opt/liquid_feedback_frontend/", "main", "custom" ]

EXPOSE 2812
