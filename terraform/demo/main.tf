module "node" {

  source = "../modules/linode-instance"

  label  = var.demo_nodename
  image  = var.linode_image_ubu2004
  region = var.linode_region_us_east
  type   = var.linode_type_5usd_1gb
  sshkeys = [
    "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDu8C0K++pvSsGA9DAfHSr4emPAx5cgizR0phgMPVpReO75X7H7oD7MjeKmxOQNc3wDibIbL2lyO7Zj16ZcX307M/2RErZEGMnpLSfme1QvBPBZHhykqkxnCYD9sKsr5H3qEVEfdWGb6kArpyewUZ1ro598QPh0GZy1YBH8aVpDcUssTGYs9ubHfMkDPPap5MKqFp8gGO79SJwKA4RUUhMzRu51xpB976+wi3CuV8Qulhq5BTzzeNxf2S8muqFv24dmkOt1IEvhbCkW9CDm/D8PMeC+oPsUJ8zbyn6PBcZaccLpBMObvRa8sk2QjuKG7tYSYMpjCdo94Xb2Fv4rg9lBfhpXdtXFpMUjpvd6gfssf/kmkX2UNrVATg3vYdf90zYzOIlk6noXtxgD/6stim83SyIekOR1f/2PDeup5wAkr1IkwLxId7+NIaEdw9uRT3VOQDjqaRM+DogYSkdtQkVubIQRiMdiWFjOEkVgNFdmUbGYqG4pJXDanjBJ0fLLkVIgl34NhTPXtq/BbFa+IT3fBkEO6G2m05j3XWKGNHNztZuP7WsGqdaQHXmEpDFj/YzSOh/AMzY2qtqAtjXupIstDNBaz5yBbedJdfJdXJnbb2YVgxtwVmI8vD2sw6+dJ/7kcuFbeBYMwxS/2WmtOR8QX59MvvUJx1CSfGucDibkRQ== iancleary@hey.com"
  ]
  root_pass = yamldecode(file("~/.config/tokens/linode.yaml"))["default-root-pass"]
}

output "ipv4" {
  value = tolist(module.node.ipv4)
}
