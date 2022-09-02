resource "vercel_project" "blog" {
  name      = "blog"
  framework = "nextjs"


  git_repository = {
    type = "github"
    repo = "iancleary/nextjs-blog"
  }
}

resource "vercel_project_domain" "blog" {
  project_id = vercel_project.blog.id
  domain     = var.domain
}

resource "vercel_project_domain" "blog_redirect" {
  project_id = vercel_project.blog.id
  domain     = "www.${var.domain}"

  redirect             = vercel_project_domain.blog.domain
  redirect_status_code = 307
}

resource "vercel_deployment" "blog" {
  project_id = vercel_project.blog.id
  ref        = "main" # or a git branch
}

resource "vercel_dns_record" "blog_www" {
  domain = var.domain
  type   = "A"
  ttl    = 60
  value  = "76.76.21.21"
  name   = "www"
}