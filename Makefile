# read ROOT_* from .env
ENV_ROOT_USER := $(shell sed -n 's/^ROOT_USER=//p' .env)
ENV_ROOT_PASS := $(shell sed -n 's/^ROOT_PASS=//p' .env)

.PHONY: up status node go count logs down reset

up:
	docker compose up -d --build

status:
	docker compose run --rm -e MONGO_HOST=mongo-0 -e MONGO_PORT=27017 -e ROOT_USER=$(ENV_ROOT_USER) -e ROOT_PASS=$(ENV_ROOT_PASS) init_mongo python3 check_replicaset_status.py

node:
	docker compose run --rm app-node

go:
	docker compose run --rm product-reader-go

count:
	# count products in appdb
	docker compose exec mongo-0 mongosh -u $(ENV_ROOT_USER) -p $(ENV_ROOT_PASS) --authenticationDatabase admin --quiet --eval 'db.getSiblingDB("appdb").products.countDocuments()'

logs:
	docker compose logs -f mongo-0 mongo-1 mongo-2 haproxy-lb

down:
	docker compose down

reset:
	docker compose down -v
	chmod 400 mongo/mongo-keyfile || true
	docker compose up -d --build
