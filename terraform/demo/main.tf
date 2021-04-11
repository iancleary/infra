terraform {
  required_providers {
    linode = {
      source = "linode/linode"
      version = "1.14.3"
    }
  }
}

provider "linode" {
  # https://developers.linode.com/api/v4/#section/Personal-Access-Token
  token = yamldecode(file("~/.config/tokens/linode.yaml"))["token"]
}


module "node" {

  source = "../modules/linode-instance"

  label  = var.demo_nodename
  image  = var.linode_image_ubu2004
  region = var.linode_region_us_west
  type   = var.linode_type_5usd_1gb
  sshkeys = [
    data.linode_sshkey.ian.ssh_key
  ]
  root_pass = yamldecode(file("~/.config/tokens/linode.yaml"))["default-root-pass"]
}

output "ipv4" {
  value = tolist(module.node.ipv4)
}
