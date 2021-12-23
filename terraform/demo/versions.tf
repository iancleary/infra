terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.25.0"
    }
  }
}

provider "linode" {
  # https://developers.linode.com/api/v4/#section/Personal-Access-Token
  token = yamldecode(file("~/.config/tokens/linode.yaml"))["token"]
}