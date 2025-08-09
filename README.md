# DevOps Task

Spin up a 3-node MongoDB replica set behind HAProxy, initialize it with Python, insert two products with Node.js, and read them back with a Go app.

## Prerequisites

- Docker + Docker Compose v2 (`docker compose …`)
- `make` (optional but convenient)

## Configuration

Create `.env` (or copy the example):

cp .env.example .env


--------
## Quickstart

# build and start all services
make up

# watch the init job (replica set init → status → create app user)
docker compose logs -f init_mongo

# insert two products (Node; runs once)
make node

# read all products (Go; runs once)
make go
