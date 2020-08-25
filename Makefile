
.PHONY: help

# Shell that make should use
# Make changes to path persistent
# https://stackoverflow.com/a/13468229/13577666
SHELL := /bin/bash
PATH := $(PATH)

# Ubuntu distro string
OS_VERSION_NAME := $(shell lsb_release -cs)

HOSTNAME = $(shell hostname)

# This next section is needed to ensure $$HOME is on PATH in the initial shell session
# The file from bash scripts/before_script_path_fix.sh
# is only loaded in a new shell session.
LOCAL_BIN = $(shell echo $$HOME/.local/bin)
# $(warning LOCAL_BIN is $(LOCAL_BIN))

# Source for conditional: https://stackoverflow.com/a/2741747/13577666
ifneq (,$(findstring $(LOCAL_BIN),$(PATH)))
	# Found: all set; do nothing, $(LOCAL_BIN) is on PATH
	PATH := $(PATH);
else
	# Not found: adding $(LOCAL_BIN) to PATH for this shell session
export PATH := $(LOCAL_BIN):$(PATH); @echo $(PATH)
endif


# Main Ansible Playbook Command (prompts for password)
ANSIBLE_PLAYBOOK = ansible-playbook home_network.yml -v -i inventory

ANSIBLE = $(ANSIBLE_PLAYBOOK) --ask-pass

# - to suppress if it doesn't exist
-include make.env

$(warning ANSIBLE is $(ANSIBLE))

help:
# http://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
# adds anything that has a double # comment to the phony help list
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | awk 'BEGIN {FS = ".:*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

bootstrap-before-install:
bootstrap-before-install:
	# Apt Dependencies (removes apt ansible)
	bash scripts/before_install_apt_dependencies.sh

bootstrap-install:
bootstrap-install:
	# Python3 Dependencies (install python3 ansible)
	bash scripts/install_python3_dependencies.sh

bootstrap-before-script:
bootstrap-before-script:
	# Ensure "$$HOME/.local/bin" is part of PATH on future shell sessions
	# The top of the Makefile takes care of this in the initial session
	bash scripts/before_script_path_fix.sh

bootstrap: bootstrap-before-install bootstrap-install bootstrap-before-script
bootstrap: ## Installs dependencies needed to run playbook

bootstrap-check:
bootstrap-check: ## Check that PATH and requirements are correct
	@ansible --version | grep "python version"

check: DARGS?=
check: ## Checks personal-computer.yml playbook
	@$(ANSIBLE) --check

lint:  ## Lint the repo
lint:
	bash scripts/lint.sh

ping:
ping: ## Ping ansible groups
	ansible pihole -m ping -i inventory --ask-pass

docs-develop:
docs-develop: ## setup pipenv to develop docs
	pipenv
	pipenv run python3 -m pip install -r requirements.txt
	pipenv shell
	# make docs-live

docs-live:
docs-live: ## create live docs
	bash scripts/docs-live.sh

docker:
docker: ## Install Docker and Docker-Compose
	@$(ANSIBLE) --tags="docker"

disable-dns-stub-resolver:
disable-dns-stub-resolver: ## Disable DNS Stub Resolver in Ubuntu (17.10+)
	# See "Installing on Ubuntu" at https://hub.docker.com/r/pihole/pihole/
	@$(ANSIBLE) --tags="disable-dns-stub-resolver"

docker-compose-template:
docker-compose-template: ## Copy Docker Compose Template
	@$(ANSIBLE) --tags="docker-compose-template"


.DEFAULT_GOAL := help
