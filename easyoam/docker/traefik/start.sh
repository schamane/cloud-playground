!#/usr/bin/env bash

<<<<<<< HEAD
docker run -d -p 8080:8080 -p 80:80 -p 443:443 -v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock -v $PWD/acme.json:/etc/traefik/acme.json --restart always traefik:1.6-alpine
=======
docker run -d -p 8080:8080 -p 80:80 -p 443:443 \
-v $PWD/traefik.toml:/etc/traefik/traefik.toml -v /var/run/docker.sock:/var/run/docker.sock \
-v $PWD/acme.json:/etc/traefik/acme.json --restart always --name traefik traefik:1.6-alpine
>>>>>>> a374e2fcf81de416839bada3d348128345613874
