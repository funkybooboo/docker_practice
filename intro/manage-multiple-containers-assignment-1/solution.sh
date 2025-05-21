#!/bin/bash

docker container run --publish 80:80 --name nginx -d nginx
docker container run --publish 8080:80 --name httpd -d httpd
docker container run --publish 3306:3306 --name mysql -d --env MYSQL_RANDOM_ROOT_PASSWORD=yes mysql
docker container ls -a
docker container logs mysql
docker container rm -f mysql httpd nginx
docker container ls -a
