# https://registry.terraform.io/providers/chronark/vercel/latest/doc
terraform {
  required_providers {
    vercel = {
      source = "vercel/vercel"
      version = "0.6.0"
    }
    linode = {
      source = "linode/linode"
      version = "1.25.0"
    }
  }
}


provider "vercel" {
  # https://vercel.com/account/tokens
  api_token = yamldecode(file("~/.config/tokens/vercel.yaml"))["token"]
}

provider "linode" {
  # https://developers.linode.com/api/v4/#section/Personal-Access-Token
  token = yamldecode(file("~/.config/tokens/linode.yaml"))["token"]
}

###### END PROVIDER CONFIGURATION ######

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