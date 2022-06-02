# https://registry.terraform.io/providers/chronark/vercel/latest/docs
resource "vercel_domain" "prod" {
  name = var.domain
}

## --------------------------------------------

resource "vercel_dns" "root" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = "76.76.21.21"
  name   = ""
}

resource "vercel_dns" "www" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = "76.76.21.21"
  name   = "www"
}


## --------------------------------------------
## SPF1
resource "vercel_dns" "spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = ""
}

resource "vercel_dns" "www_spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = "www"
}

resource "vercel_dns" "box_spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = "box"
}

resource "vercel_dns" "mta-sts_box_spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = "mta-sts.box"
}

resource "vercel_dns" "ns1_box_spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = "ns1.box"
}

resource "vercel_dns" "ns2_box_spf1" {
  domain = vercel_domain.prod.name
  type   = "TXT"
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${vercel_domain.prod.name} a:box.${vercel_domain.prod.name} ~all"
  name   = "ns2.box"
}



## --------------------------------------------
## MX
# https://github.com/vercel/terraform-provider-vercel
# https://github.com/vercel/terraform-provider-vercel/blob/main/examples/resources/vercel_dns_record/resource.tf
# 
# resource "vercel_dns" "mx" {
#   domain = vercel_domain.prod.name
#   type   = "MX"
#   value  = "box.iancleary.me"
#   name   = ""
# }

# resource "vercel_dns" "mx_box" {
#   domain = vercel_domain.prod.name
#   type   = "MX"
#   value  = "box.iancleary.me"
#   name   = "box"
# }

## --------------------------------------------
## A
resource "vercel_dns" "autoconfig_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "autoconfig"
}

resource "vercel_dns" "autodiscover_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "autodiscover"
}

resource "vercel_dns" "mta_sts_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "mta-sts"
}

resource "vercel_dns" "box_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "box"
}

resource "vercel_dns" "mta_sts_box_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "mta-sts.box"
}

resource "vercel_dns" "ns1_box_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "ns1.box"
}

resource "vercel_dns" "ns2_box_ipv4" {
  domain = vercel_domain.prod.name
  type   = "A"
  value  = var.mail_ipv4
  name   = "ns2.box"
}

## AAAA
resource "vercel_dns" "autoconfig_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "autoconfig"
}

resource "vercel_dns" "autodiscover_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "autodiscover"
}

resource "vercel_dns" "mta_sts_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "mta-sts"
}

resource "vercel_dns" "box_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "box"
}

resource "vercel_dns" "mta_sts_box_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "mta-sts.box"
}

resource "vercel_dns" "ns1_box_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "ns1.box"
}

resource "vercel_dns" "ns2_box_ipv6" {
  domain = vercel_domain.prod.name
  type   = "AAAA"
  value  = var.mail_ipv6
  name   = "ns2.box"
}


