#!/bin/bash

docker volume create psql-data
docker volume ls
docker run -d --name psql1 -e POSTGRES_PASSWORD=mypassword -v psql-data:/var/lib/postgresql/data postgres:15.1
docker container ls -a
docker logs psql1
docker stop psql1
docker run -d --name psql2 -e POSTGRES_PASSWORD=mypassword -v psql-data:/var/lib/postgresql/data postgres:15.2
docker container ls -a
docker logs psql2
docker stop psql2
