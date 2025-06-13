#!/bin/bash

set -e

echo "Creating overlay networks..."
docker network create --driver overlay frontend || echo "frontend network already exists"
docker network create --driver overlay backend || echo "backend network already exists"

echo "Creating named volume for PostgreSQL..."
docker volume create db-data || echo "db-data volume already exists"

echo "Deploying vote service (frontend)..."
docker service create \
  --name vote \
  --replicas 2 \
  --publish 80:80 \
  --network frontend \
  bretfisher/examplevotingapp_vote

echo "Deploying redis service (in-memory store)..."
docker service create \
  --name redis \
  --network frontend \
  redis:3.2

echo "Deploying worker service (backend processor)..."
docker service create \
  --name worker \
  --network frontend \
  --network backend \
  bretfisher/examplevotingapp_worker

echo "Deploying db service (PostgreSQL)..."
docker service create \
  --name db \
  --network backend \
  --mount type=volume,source=db-data,target=/var/lib/postgresql/data \
  -e POSTGRES_HOST_AUTH_METHOD=trust \
  postgres:9.4

echo "Deploying result service (admin results UI)..."
docker service create \
  --name result \
  --publish 5001:80 \
  --network backend \
  bretfisher/examplevotingapp_result

echo "All services launched. Run 'docker service ls' to confirm."
