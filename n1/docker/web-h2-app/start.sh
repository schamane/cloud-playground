#!/usr/bin/env bash

docker stop n3
docker rm n3

docker run -d --network local-bridge\
 --name n3 \
 -l "traefik.weight=1"\
 schamane/web-h2-app


