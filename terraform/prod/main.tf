terraform {
  cloud {
    organization = "iancleary"

    workspaces {
      name = "infra-prod"
    }
  }
}

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

module "mail_in_a_box_dns" {
  source = "./modules/mail-in-a-box-dns"

  host      = "box"
  domain    = "iancleary.me"
  mail_ipv4 = "74.207.249.157"
  mail_ipv6 = "2600:3C01::F03C:92FF:FE9F:BA5A"
}

resource "vercel_dns_record" "blog_cname" {
  domain = "iancleary.me"
  type   = "CNAME"
  ttl    = 60
  value  = "hashnode.network."
  name   = "blog"
}
