# infra

## Personal Infrastructure as code

I manage my (Ubuntu LTS) desktop configuration with Ansible: [iancleary/ansible-desktop](https://github.com/iancleary/ansible-desktop).

This repo continues that Infrastructure as Code philosophy
for my home and personal network.

## Calendar Versioning

This project adheres to [Calendar Versioning](https://calver.org/), YYYY.MINOR.MICRO.

## Documentation

Detailed documentation is hosted by Vercel at <https://infra.iancleary.me>.

## Gettting Started

Install apt and python dependencies:

```bash
make bootstrap
make bootstrap-check
```

## Linode API Configuration Tokens

Create an ipv4 token for your machine.

### Terraform

Modeling of of <https://github.com/selfhostedshow/infra>, I use an config file for token and default password:

```yaml
---
# ~/.config/tokens/linode.yaml
default-root-pass: "supersecretpassword"
token: 123456789abcdefghijklmnopqrstuvqxyz123456789abcdefghijklmnopqrst
```

### Ansible

Install roles and collections

```bash
ansible-galaxy install -r ansible/requirements.yml
```

--------------------------

## Changes

See [CHANGELOG](CHANGELOG.md) for history.

--------------------------

## Authors

I benefited from the source work of others, see [AUTHORS.md](docs/AUTHORS.md).

> My choice to open source my work here is to share back with you.
