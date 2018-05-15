#!/usr/bin/env bash

docker stop portainer
docker rm portainer

docker run -d --network local-bridge\
 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data\
 --restart always\
 --name portainer\
 -l "traefik.backend=portainer"\
 -l "traefik.protocol=http"\
 -l "traefik.frontend.entryPoints=https"\
 -l "traefik.frontend.passTLSCert=true"\
 -l "traefik.port=9000"\
 portainer/portainer
