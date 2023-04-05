terraform {
  required_providers {
    vercel = {
      source = "vercel/vercel"
      version = "0.6.1"
    }
    linode = {
      source  = "linode/linode"
      version = "1.29.1"
    }
  }
}

# Switched to Terraform Cloud
# provider "vercel" {
#   # https://vercel.com/account/tokens
#   api_token = yamldecode(file("~/.config/tokens/vercel.yaml"))["token"]
# }
