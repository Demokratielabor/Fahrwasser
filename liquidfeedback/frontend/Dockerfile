FROM debian:stretch

LABEL maintainer="Thomas Sänger <thomas.saenger@demokratielabor.org>"

HEALTHCHECK CMD curl -f -L http://localhost:2812/ || exit 1

ENV LQFB_MOONBRIDGE_VERSION 1.1.0
ENV LQFB_WEBMCP_VERSION 2.1.0
ENV LQFB_ROCKETWIKI_VERSION 0.4
ENV LQFB_FRONTEND_VERSION 3.2.1

ENV LANG C.UTF-8

VOLUME [ "/opt/liquid_feedback_frontend/config" ]

COPY patches /patches

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
		patch \
		postgresql-server-dev-all \
		python3-pip \
		python3-setuptools \
		rsync && \
	pip3 --no-cache-dir install markdown2 && \
	# install moonbridge
	curl -sSL http://www.public-software-group.org/pub/projects/moonbridge/v${LQFB_MOONBRIDGE_VERSION}/moonbridge-v${LQFB_MOONBRIDGE_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION} && \
	bmake -j $(nproc) MOONBR_LUA_PATH=/opt/moonbridge/?.lua && \
	mkdir -p /opt/moonbridge && \
	cp moonbridge moonbridge_http.lua /opt/moonbridge/ && \
	# install webmcp
	curl -sSL http://www.public-software-group.org/pub/projects/webmcp/v${LQFB_WEBMCP_VERSION}/webmcp-v${LQFB_WEBMCP_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/webmcp-v${LQFB_WEBMCP_VERSION} && \
	patch -p1 < /patches/webmcp/0001-use-lua5.3.patch && \
	make && \
	mkdir -p /opt/webmcp && \
	cp -RL framework/* /opt/webmcp/ && \
	# install rocketwiki
	curl -sSL http://www.public-software-group.org/pub/projects/rocketwiki/liquid_feedback_edition/v${LQFB_ROCKETWIKI_VERSION}/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION}.tar.gz | tar xzC /tmp && \
	cd /tmp/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION} && \
	make && \
	mkdir -p /opt/rocketwiki-lqfb && \
	cp rocketwiki-lqfb rocketwiki-lqfb-compat /opt/rocketwiki-lqfb && \
	# install lqfb-frontend
	curl -sSL http://www.public-software-group.org/pub/projects/liquid_feedback/frontend/v${LQFB_FRONTEND_VERSION}/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}.tar.gz | tar xzC /tmp && \
	rsync -a /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}/ /opt/liquid_feedback_frontend/. && \
	# remove build-deps
	apt-get -y purge \
		build-essential \
		bmake \
		ghc \
		lsb-release \
		patch \
		rsync && \
	apt-get -y autoremove --purge && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* && \
	rm -rf /tmp/moonbridge-v${LQFB_MOONBRIDGE_VERSION} && \
	rm -rf /tmp/webmcp-v${LQFB_WEBMCP_VERSION} && \
	rm -rf /tmp/rocketwiki-lqfb-v${LQFB_ROCKETWIKI_VERSION} && \
	rm -rf /tmp/liquid_feedback_frontend-v${LQFB_FRONTEND_VERSION}}

COPY init.template.lua /init.template.lua
COPY custom_config.lua /opt/liquid_feedback_frontend/config/custom_config.lua

COPY entrypoint.sh /entrypoint.sh

CMD "/entrypoint.sh"

EXPOSE 2812
