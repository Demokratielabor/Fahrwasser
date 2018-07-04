#!/bin/sh

sed /init.template.lua \
	-e "s/__POSTGRES_DB__/${POSTGRES_DB}/g" \
	-e "s/__POSTGRES_USER__/${POSTGRES_USER}/g" \
	-e "s/__POSTGRES_PASSWORD__/${POSTGRES_PASSWORD}/g" \
	> /opt/liquid_feedback_frontend/config/init.lua


/opt/moonbridge/moonbridge /opt/webmcp/bin/mcp.lua /opt/webmcp/ /opt/liquid_feedback_frontend/ main init
