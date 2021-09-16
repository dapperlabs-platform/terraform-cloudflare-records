# cloudflare zone for internalSubdomain
data "cloudflare_zones" "internal_subdomain" {
  filter {
    name = var.internal_subdomain
  }
}


# A record that points vanityDomain to the ingress IP
resource "cloudflare_record" "vanity_domain_dns_record" {
  zone_id = lookup(data.cloudflare_zones.internal_subdomain.zones[0], "id")
  type    = "A"
  ttl     = 1
  name    = var.vanity_domain
  value   = var.k8s_ingress_ip
  proxied = true
}

# A record that points *.internalSubdomain to the ingress
resource "cloudflare_record" "wildcard_internal_subdomain_dns_record" {
  zone_id = lookup(data.cloudflare_zones.internal_subdomain.zones[0], "id")
  type    = "A"
  ttl     = 1
  name    = "*.${var.internal_subdomain}"
  value   = var.k8s_ingress_ip
  proxied = true
}

#  Edge Certificate for vanityDomain
resource "cloudflare_certificate_pack" "internal_domain_cert_pack" {
  zone_id = lookup(data.cloudflare_zones.internal_subdomain.zones[0], "id")
  type    = "advanced"
  hosts = [
    var.internal_subdomain,
    "*.${var.internal_subdomain}"
  ]
  validation_method     = "http"
  validity_days         = 365
  certificate_authority = "digicert"
  cloudflare_branding   = false
}
