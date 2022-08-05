terraform {
  cloud {
    organization = "iancleary"

    workspaces {
      name = "infra-dev"
    }
  }
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