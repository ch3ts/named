
DOCKER=docker
DC=/usr/local/bin/docker-compose

ifdef BIND_VERSION
	ARG=-e BIND_VERSION=$(BIND_VERSION)
endif

all:
start:
	@$(DC) run $(ARG) bind

stop:
	@$(DC) down

restart:
	@$(DC) up --force-recreate

build:
	@$(DOCKER) build -t bind9 .

shell:
	@$(DC) exec bind bash

.PHONY: clean

clean:
	rm -rf data/build/*
