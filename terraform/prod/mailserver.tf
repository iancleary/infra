resource "linode_instance" "cloud1" { 
  image  = var.linode_image_ubu2004
  label  = var.nodename
  region = var.linode_region_us_west
  type   = var.linode_type_5usd_1gb
  authorized_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqgjLpnd6UuOkyZXBh9JcHyH0QLpi59EvjNvBkQlwzt hello@iancleary.me"
  ]
  root_pass = var.linode_default_root_password
}