
# Linode Terraform Setup

## Setup Linode ipv4 token

I use an environment variable for my access token.

```bash
export TF_VAR_LINODE_TOKEN=replace_me
```

## Add support for third-party provider

The terraform provider setup for Linode was elusive initially.

> Add the following to the top of your `main.tf` file:

```json
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
