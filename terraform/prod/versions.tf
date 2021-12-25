terraform {
  required_providers {
    vercel = {
      source = "chronark/vercel"
      version = "0.14.2"
    }
  }
}

provider "vercel" {
  # https://vercel.com/account/tokens
  token = yamldecode(file("~/.config/tokens/vercel.yaml"))["token"]
}

