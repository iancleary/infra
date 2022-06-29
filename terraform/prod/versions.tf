terraform {
  required_providers {
    vercel = {
      source = "vercel/vercel"
      version = "0.6.0"
    }
  }
}

provider "vercel" {
  # https://vercel.com/account/tokens
  api_token = yamldecode(file("~/.config/tokens/vercel.yaml"))["token"]
}

