
# Linode Terraform Setup

## Setup Linode ipv4 token

Modeling of of <https://github.com/selfhostedshow/infra>, I use an config file for token and default password:

```yaml
---
- default-root-pass: "supersecretpassword"
- token: 123456789abcdefghijklmnopqrstuvqxyz123456789abcdefghijklmnopqrst

```bash
export TF_VAR_LINODE_TOKEN=replace_me
```

## Add support for third-party provider

The terraform provider setup for Linode was elusive initially.

> Add the following to the top of your `main.tf` file:

```tf
// main.tf
terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.14.3"
    }
  }
}
```
