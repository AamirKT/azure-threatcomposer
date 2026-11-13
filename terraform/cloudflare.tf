resource "cloudflare_dns_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = "aamir-threatcomposer.co.uk"
  type    = "A"
  content = "51.105.49.144"
  ttl     = 1
  proxied = false
}

resource "cloudflare_dns_record" "www" {
  zone_id = var.cloudflare_zone_id
  name    = "www.aamir-threatcomposer.co.uk"
  type    = "CNAME"
  content = "aamir-threatcomposer.co.uk"
  ttl     = 1
  proxied = false
}