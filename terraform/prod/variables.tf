variable "domain" {
  type    = string
}

variable "mail_ipv4" {
  type    = string
}

variable "mail_ipv6" {
  type    = string
}

variable "nodename" {
  type = string
}

variable "linode_image_ubu2004" {
  type    = string
  default = "linode/ubuntu20.04"
}

variable "linode_image_ubu2204" {
  type    = string
  default = "linode/ubuntu22.04"
}

variable "linode_region_us_west" {
  type    = string
  default = "us-west"
}

variable "linode_region_us_central" {
  type    = string
  default = "us-central"
}
variable "linode_region_us_east" {
  type    = string
  default = "us-east"
}

variable "linode_region_uk" {
  type    = string
  default = "eu-west"
}

## linode-cli sshkeys list
# data "linode_sshkey" "ian" {
#   label = "ian"
# }

variable "linode_type_5usd_1gb" {
  #1vcpu, 1gb, 25gb
  type    = string
  default = "g6-nanode-1"
}

variable "linode_type_10usd_2gb" {
  #1vcpu, 2gb, 50gb
  type    = string
  default = "g6-standard-1"
}

variable "linode_type_20usd_4gb" {
  #2vcpu, 4gb, 80gb
  type    = string
  default = "g6-standard-2"
}

variable "linode_type_40usd_8gb" {
  #4vcpu, 8gb, 160gb
  type    = string
  default = "g6-standard-3"
}

variable "linode_default_root_password" {
  type    = string
}