
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

ANSIBLE = $(ANSIBLE_PLAYBOOK) --ask-become-pass

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

non-ansible:
non-ansible: ## Runs all non-ansible make targets for fresh install (all target)

	# No user input required
	make flameshot-keybindings

	# Ubuntu 20.04 defaults
	make python-three-eight-install
	make python-three-eight-supporting

lint:  ## Lint the repo
lint:
	bash scripts/lint.sh

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

python-three-eight-install: ## Install python3.8 using apt (main install)
python-three-eight-install:

	sudo apt-get update

	# Start by updating the packages list and installing the prerequisites:
	sudo apt install software-properties-common

	# Once the repository is enabled, install Python 3.8 with: (added libpython3.8-dev for pip installs)
	# - httptools wasn't installing correctly until adding it
	# - see: https://github.com/huge-success/sanic/issues/1503#issuecomment-469031275
	sudo apt update
	sudo apt install -y python3.8 libpython3.8-dev

	# At this point, Python 3.8 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.8 --version

python-three-eight-supporting: ## Install useful packages
python-three-eight-supporting:

	# python3 pip
	sudo apt install -y python3-pip

	# upgrade pip
	python3.8 -m pip install --user --upgrade pip
	-python3.8 -m pip install --upgrade keyrings.alt --user
	-python3.8 -m pip install --user --upgrade setuptools

	# At this point, Python 3.7 is installed on your Ubuntu system and ready to be used.
	# You can verify it by typing:
	python3.8 --version
	python3.8 -m pip --version

	python3.8 -m pip install --user pipenv
	# https://python-poetry.org/docs/
	python3.8 -m pip install --user poetry
	sudo apt-get install -y python3-venv
	# https://github.com/python-poetry/poetry/issues/721#issuecomment-623399861
	# Ubuntu 20.04 https://wiki.ubuntu.com/FocalFossa/ReleaseNotes#Python3_by_default
	-sudo apt install python-is-python3

.DEFAULT_GOAL := help
