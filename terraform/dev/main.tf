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
# resource "linode_instance" "cloud1" { 

  
#   image  = var.linode_image_ubu2004
#   label  = var.nodename
#   region = var.linode_region_us_west
#   type   = var.linode_type_5usd_1gb
#   authorized_keys = [
#     data.linode_sshkey.ian.ssh_key
#   ]
#   root_pass = yamldecode(file("~/.config/tokens/linode.yaml"))["default-root-pass"]
# }

# output "cloud1_ipv4" {
#   value = tolist(linode_instance.cloud1.ipv4)[0]
# }

# output "cloud1_ipv6" {
#   value = replace(linode_instance.cloud1.ipv6, "/128", "")
# }

# locals {
#   cloud1_ipv4 = tolist(linode_instance.cloud1.ipv4)[0]
#   cloud1_ipv6 = replace(linode_instance.cloud1.ipv6, "/128", "")
# }

# resource "vercel_domain" "dev" {
#   provider = vercel
#   name = var.domain
# }

# resource "vercel_dns" "root" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = ""
# }
# resource "vercel_dns" "www" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "www"
# }


# ## --------------------------------------------
# ## SPF1
# resource "vercel_dns" "spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = ""
# }

# resource "vercel_dns" "www_spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = "www"
# }

# resource "vercel_dns" "box_spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = "${var.nodename}"
# }

# resource "vercel_dns" "mta-sts_box_spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = "mta-sts.${var.nodename}"
# }

# resource "vercel_dns" "ns1_box_spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = "ns1.${var.nodename}"
# }

# resource "vercel_dns" "ns2_box_spf1" {
#   domain = vercel_domain.dev.name
#   type   = "TXT"
#   value  = "v=spf1 mx ip4:${local.cloud1_ipv4} a:${vercel_domain.dev.name} a:${var.nodename}.${vercel_domain.dev.name} ~all"
#   name   = "ns2.${var.nodename}"
# }



## --------------------------------------------
## MX
# https://github.com/chronark/terraform-provider-vercel/issues/51
# 
# resource "vercel_dns" "mx" {
#   domain = vercel_domain.dev.name
#   type   = "MX"
#   value  = "mail.mailroute.net."
#   name   = ""
# }

# resource "vercel_dns" "mx_box" {
#   domain = vercel_domain.dev.name
#   type   = "MX"
#   value  = "mail.mailroute.net."
#   name   = "${var.nodename}"
# }

## --------------------------------------------
## A
# resource "vercel_dns" "autoconfig_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "autoconfig"
# }

# resource "vercel_dns" "autodiscover_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "autodiscover"
# }

# resource "vercel_dns" "mta_sts_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "mta-sts"
# }

# resource "vercel_dns" "box_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "${var.nodename}"
# }

# resource "vercel_dns" "mta_sts_box_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "mta-sts.${var.nodename}"
# }

# resource "vercel_dns" "ns1_box_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "ns1.${var.nodename}"
# }

# resource "vercel_dns" "ns2_box_ipv4" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = local.cloud1_ipv4
#   name   = "ns2.${var.nodename}"
# }

# ## AAAA
# resource "vercel_dns" "autoconfig_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "autoconfig"
# }

# resource "vercel_dns" "autodiscover_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "autodiscover"
# }

# resource "vercel_dns" "mta_sts_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "mta-sts"
# }

# resource "vercel_dns" "box_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "${var.nodename}"
# }

# resource "vercel_dns" "mta_sts_box_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "mta-sts.${var.nodename}"
# }

# resource "vercel_dns" "ns1_box_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "ns1.${var.nodename}"
# }

# resource "vercel_dns" "ns2_box_ipv6" {
#   domain = vercel_domain.dev.name
#   type   = "AAAA"
#   value  = local.cloud1_ipv6
#   name   = "ns2.${var.nodename}"
# }