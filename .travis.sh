#!/bin/bash

cd pgbouncer || exit 1
docker build -t demolab/fahrwasser_pgbouncer:$TRAVIS_BRANCH || exit 1

cd ../pgbouncer-exporter || exit 1
docker build -t demolab/fahrwasser_pgbouncer_exporter:$TRAVIS_BRANCH || exit 1

cd ../liquidfeedback/core || exit 1
docker build -t demolab/fahrwasser_lqfb_core:$TRAVIS_BRANCH || exit 1

cd ../frontend || exit 1
docker build -t demolab/fahrwasser_lqfb_frontend:$TRAVIS_BRANCH || exit 1
