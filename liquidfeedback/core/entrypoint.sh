#!/bin/sh

LQFB_PG_CONN="host=${POSTGRES_HOST} dbname=${POSTGRES_DB} user=${POSTGRES_USER} password=${POSTGRES_PASSWORD}"

while true; do
    /opt/liquid_feedback_core/lf_update ${LQFB_PG_CONN} 2>&1
    /opt/liquid_feedback_core/lf_update_issue_order ${LQFB_PG_CONN} 2>&1
    /opt/liquid_feedback_core/lf_update_suggestion_order ${LQFB_PG_CONN} 2>&1
    sleep 5
done
