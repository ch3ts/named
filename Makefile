
DOCKER=docker
DC=/usr/local/bin/docker-compose

all:
start:
	@$(DC) up

stop:
	@$(DC) down

restart:
	@$(DC) up --force-recreate

build:
	@$(DOCKER) build -t bind9 .

shell:
	@$(DOCKER) exec -t bind9 bash

.PHONY: clean

clean:
	rm -rf data/build/*
