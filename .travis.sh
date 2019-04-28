#!/bin/bash

docker build -t demolab/fahrwasser_pgbouncer:$TRAVIS_BRANCH pgbouncer || exit 1

docker build -t demolab/fahrwasser_pgbouncer_exporter:$TRAVIS_BRANCH pgbouncer-exporter || exit 1

docker build -t demolab/fahrwasser_lqfb_core:$TRAVIS_BRANCH liquidfeedback/core || exit 1

docker build -t demolab/fahrwasser_lqfb_frontend:$TRAVIS_BRANCH liquidfeedback/frontend || exit 1
