# https://registry.terraform.io/providers/chronark/vercel/latest/docs
resource "vercel_domain" "dev" {
  name = var.domain
}

# resource "vercel_dns" "www" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = "76.76.21.21"
#   name   = "www"
# }

# resource "vercel_dns" "www2" {
#   domain = vercel_domain.dev.name
#   type   = "A"
#   value  = "76.76.21.21"
#   name   = "www2"
# }