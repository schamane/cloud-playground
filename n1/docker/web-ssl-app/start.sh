#!/usr/bin/env bash

docker stop n2
docker rm n2

docker run -d --network local-bridge\
 --name n2 \
 schamane/web-ssl-app


