# Build sible docker environment

## Start with Portainer

create docker volume for Portainer

```
docker volume create portainer_data
```

start Portainer

```
docker run -d --restart always -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer
```
