#!/usr/bin/env bash

docker stop mongo
docker rm mongo

docker stack deploy -c stack.yml mongo


