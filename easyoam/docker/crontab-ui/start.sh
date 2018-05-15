#!/usr/bin/env bash

docker stop cron
docker rm cron

docker run -d --name cron --network local-bridge\
 -v "$PWD/jobs:/jobs"\
 --restart always\
 -l "traefik.backend=crontab-ui"\
 -l "traefik.protocol=http"\
 -l "traefik.frontend.entryPoints=https"\
 -l "traefik.frontend.passTLSCert=true"\
 -l "traefik.port=8000"\
 alseambusher/crontab-ui
