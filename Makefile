
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
ANSIBLE_PING = cd ansible && ansible terraform -m ping -v

ANSIBLE_PLAYBOOK = cd ansible && ansible-playbook playbook.yml -v

# - to suppress if it doesn't exist
-include make.env

$(warning ANSIBLE_PING is $(ANSIBLE_PING))
$(warning ANSIBLE_PLAYBOOK is $(ANSIBLE_PLAYBOOK))

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
	terraform --version

check: DARGS?=
check: ## Checks personal-computer.yml playbook
	@$(ANSIBLE_PLAYBOOK) --check

lint:  ## Lint the repo
lint:
	bash scripts/lint.sh

tfinit:
tfinit: ## Setup Terraform Providers
	cd terraform/demo; terraform init

tfcreate:
tfcreate: ## Demo Terraform Create
	cd terraform/demo; terraform apply

tfdestroy:
tfdestroy: ## Demo Terraform Destroy
	cd terraform/demo; terraform destroy

ansible-inventory:
ansible-inventory: ## Show ansible inventory
	cd ansible; ansible-inventory --list

ansible-ping:
ansible-ping: ## Ping ansible groups
	@$(ANSIBLE_PING)

ansible-linode:
ansible-linode: ## Install Docker and Docker-Compose
	@$(ANSIBLE_PLAYBOOK) --tags="install-docker"

.DEFAULT_GOAL := help
