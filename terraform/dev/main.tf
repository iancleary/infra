terraform {
  cloud {
    organization = "iancleary"

    workspaces {
      name = "infra-dev"
    }
  }
}

provider "linode" {
    token = var.linode_token
}

resource "vercel_project" "portfolio" {
  name      = "dev"
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

resource "vercel_deployment" "portfolio_example" {
  project_id = vercel_project.portfolio.id
  ref        = "main" # or a git branch
}

# resource "linode_instance" "docker_mailserver" {
#   image  = var.linode_image_ubu2204
#   label  = var.nodename
#   region = var.linode_region_us_west
#   type   = var.linode_type_5usd_1gb
#   authorized_keys = [
#     data.linode_sshkey.ian.ssh_key
#   ]
#   root_pass = var.linode_default_root_password
# }

# output "ipv4" {
#   value = tolist(linode_instance.docker_mailserver.ipv4)[0]
# }

# output "ipv6" {
#   value = replace(linode_instance.docker_mailserver.ipv6, "/128", "")
# }

# locals {
#   ipv4 = tolist(linode_instance.docker_mailserver.ipv4)[0]
#   ipv6 = replace(linode_instance.docker_mailserver.ipv6, "/128", "")
# }
