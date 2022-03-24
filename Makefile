SHELL := /bin/bash
VERSION ?= $(shell git describe --match=NeVeRmAtCh --always --abbrev=8 --dirty)
DOCKER_IMAGE ?= ci4rail/dev-edgefarm-nats
ifneq (,$(wildcard ./version.env))
    include version.env
    export
endif

build: ## build docker image (prefix dev-)
	@echo "${NATS_LEAFNODE_REGISTRY_VERSION}"
	@echo "${NATS_SERVER_VERSION}"
	docker build -f Dockerfile --build-arg NATS_LEAFNODE_REGISTRY_VERSION=${NATS_LEAFNODE_REGISTRY_VERSION} --build-arg NATS_SERVER_VERSION=${NATS_SERVER_VERSION} -t ${DOCKER_IMAGE}:${VERSION} -t ${DOCKER_IMAGE}:latest . 

push: build ## push docker image (prefix dev-)
	docker push ${DOCKER_IMAGE}:${VERSION}
	docker push ${DOCKER_IMAGE}:latest

.PHONY: build push

help: ## show help message
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make [target]\033[36m\033[0m\n"} /^[$$()% 0-9a-zA-Z_-]+:.*?##/ { printf "  \033[36m%-15s\033[0m\t %s\n", $$1, $$2 } /^##@/ { printf "\n\033[1m%s\033[0m\n", substr($$0, 5) } ' $(MAKEFILE_LIST)