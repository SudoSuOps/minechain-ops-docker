SHELL := /bin/bash

.PHONY: build push test compose-miner compose-monitoring

build:
	scripts/build.sh

push:
	scripts/push.sh

test:
	scripts/test.sh

compose-miner:
	docker compose -f compose/miner-compose.yml up -d

compose-monitoring:
	docker compose -f compose/monitoring-compose.yml up -d
