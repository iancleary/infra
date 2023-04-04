resource "vercel_project" "spotlight" {
  name      = "spotlight"
  framework = "nextjs"


  git_repository = {
    type = "github"
    repo = "iancleary/spotlight"
  }
}

resource "vercel_project_domain" "spotlight" {
  project_id = vercel_project.spotlight.id
  domain     = var.domain
}

resource "vercel_project_domain" "blog_redirect" {
  project_id = vercel_project.spotlight.id
  domain     = "www.${var.domain}"

  redirect             = vercel_project_domain.spotlight.domain
  redirect_status_code = 307
}

resource "vercel_deployment" "spotlight" {
  project_id = vercel_project.spotlight.id
  ref        = "main" # or a git branch
}

resource "vercel_dns_record" "blog_www" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = "76.76.21.21"
  name   = "www"
}
