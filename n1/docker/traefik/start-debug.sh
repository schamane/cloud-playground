#!/usr/bin/env bash

docker stop traefik
docker rm traefik

docker run -d -p 8080:8080 -p 80:80 -p 443:443 \
 -v $PWD/traefik-debug.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock \
 -v traefik_acme:/etc/traefik/acme --restart always \
 --name traefik \
 traefik:1.6-alpine

docker network connect local-bridge traefik

