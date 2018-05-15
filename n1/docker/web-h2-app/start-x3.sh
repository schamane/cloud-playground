#!/usr/bin/env bash

docker stop x3
docker rm x3

docker run -d --network local-bridge\
 --name x3 \
 -l "traefik.weight=2"\
 schamane/web-h2-app


