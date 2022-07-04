# output "domain" {
#   value = var.domain
# }

# resource "vercel_dns_record" "mx" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = format("%s.%s",var.host,var.domain)
#   name   = ""
#   mx_priority = 10
# }


resource "vercel_dns_record" "mx" {
  domain = var.domain
  type   = "MX"
  ttl    = 60
  value  = format("%s.%s",var.host,var.domain)
  name   = ""
  mx_priority = 10
}

# Primary MX Record
resource "vercel_dns_record" "mx_box" {
  domain = var.domain
  type   = "MX"
  ttl    = 60
  value  = format("%s.%s",var.host,var.domain)
  name   = "box"
  mx_priority = 10
}

resource "vercel_dns_record" "box_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "box"
}
resource "vercel_dns_record" "box_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "box"
}

resource "vercel_dns_record" "spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = ""
}

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_autoconfig" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "autoconfig"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_autodiscover" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "autodiscover"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_mta-sts_box" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "mta-sts.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.

# resource "vercel_dns_record" "mx_ns1_box" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "ns1.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_ns2_box" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "ns2.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_mta-sts" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "mta-sts"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_www" {
#   domain = var.domain
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "www"
#   mx_priority = 10
# }




resource "vercel_dns_record" "autodiscover_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "autodiscover"
}

resource "vercel_dns_record" "autoconfig_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "autoconfig"
}


resource "vercel_dns_record" "www_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "www"
}

resource "vercel_dns_record" "box_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${var.domain} a:box.${var.domain} ~all"
  name   = "box"
}

resource "vercel_dns_record" "mta-sts_box_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_spf1" {
  domain = var.domain
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "ns2.box"
}


## --------------------------------------------
## A
resource "vercel_dns_record" "autoconfig_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "autoconfig"
}

resource "vercel_dns_record" "autodiscover_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "autodiscover"
}

resource "vercel_dns_record" "mta_sts_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "mta-sts"
}


resource "vercel_dns_record" "mta_sts_box_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_ipv4" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "ns2.box"
}

## AAAA
resource "vercel_dns_record" "autoconfig_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "autoconfig"
}

resource "vercel_dns_record" "autodiscover_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "autodiscover"
}

resource "vercel_dns_record" "mta_sts_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "mta-sts"
}



resource "vercel_dns_record" "mta_sts_box_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_ipv6" {
  domain = var.domain
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "ns2.box"
}

resource "vercel_dns_record" "caldav_src" {
  domain = var.domain
  type   = "SRV"
  ttl    = 60
  srv = {
    port     = 443
    weight   = 65534
    priority = 65534
    target   = format("%s.%s.",var.host,var.domain)
  }
  name   = "_caldavs._tcp"
}

resource "vercel_dns_record" "carddav_src" {
  domain = var.domain
  type   = "SRV"
  ttl    = 60
  srv = {
    port     = 443
    weight   = 65534
    priority = 65534
    target   = format("%s.%s.",var.host,var.domain)
  }
  name   = "_carddavs._tcp"
}


