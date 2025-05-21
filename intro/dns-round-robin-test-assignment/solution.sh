#!/bin/bash

docker network create dude
docker container run -d --net dude --net-alias search elasticsearch:2
docker container ls -a
docker container run --rm --net dude alpine nslookup search
docker container run --rm --net dude centos:7 curl -s search:9200
docker container ls -a
docker container rm -f elated_lamport serene_nobel 
