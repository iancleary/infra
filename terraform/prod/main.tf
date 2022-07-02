resource "vercel_project" "portfolio" {
  name      = "portfolio"
  framework = "nextjs"


  git_repository = {
    type = "github"
    repo = "iancleary/portfolio"
  }
}

resource "vercel_project_domain" "portfolio" {
  project_id = vercel_project.portfolio.id
  domain     = var.domain
}

# A redirect of a domain name to a second domain name.
# The status_code can optionally be controlled.
resource "vercel_project_domain" "portfolio_redirect" {
  project_id = vercel_project.portfolio.id
  domain     = "www.${var.domain}"

  redirect             = vercel_project_domain.portfolio.domain
  redirect_status_code = 307
}

resource "vercel_deployment" "portfolio" {
  project_id = vercel_project.portfolio.id
  ref        = "main" # or a git branch
}

resource "vercel_dns_record" "www" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = "76.76.21.21"
  name   = "www"
}

output "domain" {
  value = var.domain
}


resource "vercel_dns_record" "mx" {
  domain = "iancleary.me"
  type   = "MX"
  ttl    = 60
  value  = "box.iancleary.me"
  name   = ""
  mx_priority = 10
}

# Primary MX Record
resource "vercel_dns_record" "mx_box" {
  domain = "iancleary.me"
  type   = "MX"
  ttl    = 60
  value  = "box.iancleary.me"
  name   = "box"
  mx_priority = 10
}

resource "vercel_dns_record" "box_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "box"
}
resource "vercel_dns_record" "box_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "box"
}

resource "vercel_dns_record" "spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = ""
}

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_autoconfig" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "autoconfig"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_autodiscover" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "autodiscover"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_mta-sts_box" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "mta-sts.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.

# resource "vercel_dns_record" "mx_ns1_box" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "ns1.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_ns2_box" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "ns2.box"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_mta-sts" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "mta-sts"
#   mx_priority = 10
# }

# # Prevents use of this domain name for incoming mail.
# resource "vercel_dns_record" "mx_www" {
#   domain = "iancleary.me"
#   type   = "MX"
#   ttl    = 60
#   value  = "."
#   name   = "www"
#   mx_priority = 10
# }




resource "vercel_dns_record" "autodiscover_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "autodiscover"
}

resource "vercel_dns_record" "autoconfig_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "autoconfig"
}


resource "vercel_dns_record" "www_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "www"
}

resource "vercel_dns_record" "box_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx ip4:${var.mail_ipv4} a:${var.domain} a:box.${var.domain} ~all"
  name   = "box"
}

resource "vercel_dns_record" "mta-sts_box_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_spf1" {
  domain = "iancleary.me"
  type   = "TXT"
  ttl    = 60
  value  = "v=spf1 mx -all"
  name   = "ns2.box"
}


## --------------------------------------------
## A
resource "vercel_dns_record" "autoconfig_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "autoconfig"
}

resource "vercel_dns_record" "autodiscover_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "autodiscover"
}

resource "vercel_dns_record" "mta_sts_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "mta-sts"
}


resource "vercel_dns_record" "mta_sts_box_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_ipv4" {
  domain = "iancleary.me"
  type   = "A"
  ttl    = 60
  value  = var.mail_ipv4
  name   = "ns2.box"
}

## AAAA
resource "vercel_dns_record" "autoconfig_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "autoconfig"
}

resource "vercel_dns_record" "autodiscover_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "autodiscover"
}

resource "vercel_dns_record" "mta_sts_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "mta-sts"
}



resource "vercel_dns_record" "mta_sts_box_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "mta-sts.box"
}

resource "vercel_dns_record" "ns1_box_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "ns1.box"
}

resource "vercel_dns_record" "ns2_box_ipv6" {
  domain = "iancleary.me"
  type   = "AAAA"
  ttl    = 60
  value  = var.mail_ipv6
  name   = "ns2.box"
}

resource "vercel_dns_record" "caldav_src" {
  domain = "iancleary.me"
  type   = "SRV"
  ttl    = 60
  srv = {
    port     = 443
    weight   = 65534
    priority = 65534
    target   = "box.iancleary.me."
  }
  name   = "_caldavs._tcp"
}

resource "vercel_dns_record" "carddav_src" {
  domain = "iancleary.me"
  type   = "SRV"
  ttl    = 60
  srv = {
    port     = 443
    weight   = 65534
    priority = 65534
    target   = "box.iancleary.me."
  }
  name   = "_carddavs._tcp"
}


