# infra

## Personal Infrastructure as code

I manage my (Ubuntu LTS) desktop configuration with Ansible: [iancleary/ansible-desktop](https://github.com/iancleary/ubuntu-dev-playbook).

This repo demonstrates my use of the Infrastructure as Code philosophy using [ansible](https://docs.ansible.com/ansible_community.html) and [terraform](https://www.terraform.io/).

## Gettting Started

Install [ansible](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html) and [terraform](https://www.terraform.io/downloads)

## Tokens

Modeling of of <https://github.com/selfhostedshow/infra>, I use an config file for token and default password for Linode.  I've extended this concept for Vercel as well.  These tokens are used with Terraform.

### Linode
```yaml
---
# ~/.config/tokens/linode.yaml
default-root-pass: "supersecretpassword"
token: 123456789abcdefghijklmnopqrstuvqxyz123456789abcdefghijklmnopqrst
```

### Vercel

```yaml
---
# ~/.config/tokens/vercel.yaml
token: qrstuvqxyz123456789abcdefghi
```
