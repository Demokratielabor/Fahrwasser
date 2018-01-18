#!/bin/sh

PIDFILE="/tmp/lf_updated.pid"
PID=$$

if [ -f "${PIDFILE}" ] && kill -CONT $( cat "${PIDFILE}" ); then
    echo "lf_updated is already running."
    exit 1
fi

echo "${PID}" > "${PIDFILE}"

# LQFB_PG_CONN is set via docker
while true; do
    /opt/liquid_feedback_core/lf_update ${LQFB_PG_CONN} 2>&1
    /opt/liquid_feedback_core/lf_update_issue_order ${LQFB_PG_CONN} 2>&1
    /opt/liquid_feedback_core/lf_update_suggestion_order ${LQFB_PG_CONN} 2>&1
    sleep 5
done
