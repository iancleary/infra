terraform {
  cloud {
    organization = "iancleary"

    workspaces {
      name = "infra-prod"
    }
  }
}



output "domain" {
  value = var.domain
}

module "mail_in_a_box_dns" {
  source = "./modules/mail-in-a-box-dns"

  host      = "box"
  domain    = var.domain
  mail_ipv4 = "74.207.249.157"
  mail_ipv6 = "2600:3C01::F03C:92FF:FE9F:BA5A"
}

# resource "vercel_dns_record" "blog_cname" {
#   domain = var.domain
#   type   = "CNAME"
#   ttl    = 60
#   value  = "hashnode.network."
#   name   = "blog"
# }
