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
