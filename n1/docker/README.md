# Build sible docker environment

## Start with Portainer

create docker volume for Portainer

```
docker volume create portainer_data
```

start Portainer

```
docker run -d --restart always -p 9000:9000 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  -v portainer_data:/data --name portainer \
  -l "traefik.frontend.rule=Host:portainer.n1.easyoam.de" \
  portainer/portainer
```

## Start cron-ui

```
docker run -d --name cron-ui -p 81:8000 --restart always alseambusher/crontab-ui
```
