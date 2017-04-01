
DOCKER=docker
DC=docker-compose
PERL_SCRIPT=latest_version.pl


ifeq ($(shell test -e .bind_version && echo -n yes), yes)
	VERSION=$(shell cat .bind_version)
endif



all: start

latest-version:
	@perl $(PERL_SCRIPT)

start:
	@$(DC) run $(VERSION) bind

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
	rm -rf data/build/* .bind_version
