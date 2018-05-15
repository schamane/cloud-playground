#!/usr/bin/env bash

docker stop y3
docker rm y3

docker run -d --network local-bridge\
 --name y3\
 -l "traefik.weight=3"\
 schamane/web-h2-app


