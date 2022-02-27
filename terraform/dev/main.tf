# https://registry.terraform.io/providers/chronark/vercel/latest/doc
terraform {
  required_providers {
    vercel = {
      source = "chronark/vercel"
      version = "0.14.2"
    }
    linode = {
      source = "linode/linode"
      version = "1.25.0"
    }
  }
}


provider "vercel" {
  # https://vercel.com/account/tokens
  token = yamldecode(file("~/.config/tokens/vercel.yaml"))["token"]
}

provider "linode" {
  # https://developers.linode.com/api/v4/#section/Personal-Access-Token
  token = yamldecode(file("~/.config/tokens/linode.yaml"))["token"]
}

###### END PROVIDER CONFIGURATION ######
resource "linode_instance" "cloud1" { 

  
  image  = var.linode_image_ubu2004
  label  = var.nodename
  region = var.linode_region_us_west
  type   = var.linode_type_5usd_1gb
  authorized_keys = [
    data.linode_sshkey.ian.ssh_key
  ]
  root_pass = yamldecode(file("~/.config/tokens/linode.yaml"))["default-root-pass"]
}

output "cloud1_ipv4" {
  value = tolist(linode_instance.cloud1.ipv4)[0]
}

locals {
  cloud1_ipv4 = tolist(linode_instance.cloud1.ipv4)[0]
}

resource "vercel_domain" "dev" {
  provider = vercel
  name = var.domain
}

resource "vercel_dns" "www" {
  domain = vercel_domain.dev.name
  type   = "A"
  value  = local.cloud1_ipv4
  name   = "www"
}