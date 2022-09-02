resource "vercel_project" "new_component" {
  name      = "new-component"
  build_command = "mkdocs build"
  output_directory = "site"
  install_command = "pip install mkdocs-material"

  git_repository = {
    type = "github"
    repo = "iancleary/new-component"
  }
}

resource "vercel_project_domain" "new_component" {
  project_id = vercel_project.new_component.id
  domain     = "new-component.${var.domain}"
}

# A redirect of a domain name to a second domain name.
# The status_code can optionally be controlled.
resource "vercel_project_domain" "new_component_redirect" {
  project_id = vercel_project.new_component.id
  domain     = "www.new-component.${var.domain}"

  redirect             = vercel_project_domain.new_component.domain
  redirect_status_code = 307
}

resource "vercel_deployment" "new_component" {
  project_id = vercel_project.new_component.id
  ref        = "main" # or a git branch
}
