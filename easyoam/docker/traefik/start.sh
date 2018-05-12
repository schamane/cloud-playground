!#/usr/bin/env bash

docker run -d -p 8080:8080 -p 80:80 -p 443:443 -v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock traefik:1.6-apline
