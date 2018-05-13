!#/usr/bin/env bash

docker run -d -p 8080:8080 -p 80:80 -p 443:443 \
-v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock \
-v $PWD/acme.json:/etc/traefik/acme.json --restart always --name traefik traefik:1.6-alpine
