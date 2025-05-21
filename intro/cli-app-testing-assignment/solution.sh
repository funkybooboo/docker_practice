#!/bin/bash

docker container run --name centos --network my_app_net -it centos:7 bash

docker container run --name ubuntu --network my_app_net -it ubuntu:14.04 bash
