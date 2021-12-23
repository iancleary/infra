resource "vercel_domain" "icancclearynow_com" {
  name = var.dev_domain
}

resource "vercel_dns" "www" {
  domain = vercel_domain.icancclearynow_com.name
  type   = "A"
  value  = "76.76.21.21"
  name   = "www"
}

resource "vercel_dns" "www2" {
  domain = vercel_domain.icancclearynow_com.name
  type   = "A"
  value  = "76.76.21.21"
  name   = "www2"
}