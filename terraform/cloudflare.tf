resource "cloudflare_dns_record" "app" {
  zone_id = var.cloudflare_zone_id
  name    = "aamir-threatcomposer.co.uk"
  type    = "A"
  content = module.application_gateway.application_gateway_public_ip
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