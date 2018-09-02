#!/bin/sh

echo "default: ${MAIL_TO}" > /etc/aliases

sed /msmtprc.template \
	-e "s/__MAIL_HOST__/${MAIL_HOST}/g" \
	-e "s/__MAIL_PORT__/${MAIL_PORT}/g" \
	-e "s/__MAIL_USER__/${MAIL_USER}/g" \
	-e "s/__MAIL_PASSWORD__/${MAIL_PASSWORD}/g" \
	-e "s/__MAIL_FROM__/${MAIL_FROM}/g" \
	> /etc/msmtprc


sed /init.template.lua \
	-e "s/__POSTGRES_HOST__/${POSTGRES_HOST}/g" \
	-e "s/__POSTGRES_DB__/${POSTGRES_DB}/g" \
	-e "s/__POSTGRES_USER__/${POSTGRES_USER}/g" \
	-e "s/__POSTGRES_PASSWORD__/${POSTGRES_PASSWORD}/g" \
	> /opt/liquid_feedback_frontend/config/init.lua


/opt/moonbridge/moonbridge /opt/webmcp/bin/mcp.lua /opt/webmcp/ /opt/liquid_feedback_frontend/ main init
