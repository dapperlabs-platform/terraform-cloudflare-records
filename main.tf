terraform {
  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = ">= 2.25.0"
    }
  }
}

locals {
  wildcard = var.subdomain != "*" ? "*.${var.subdomain}" : var.subdomain
  # result is IP string if var.destination is an IP address, null otherwise
  regex_result = try(regex("^(?:[0-9]{1,3}\\.){3}[0-9]{1,3}$", var.destination), null)
  # destination is an IP address if regex_result is not null.
  is_a_record = local.regex_result != null
  validation_methods = {
    "google"       = "txt"
    "lets_encrypt" = "http"
  }
}

data "cloudflare_zone" "zone" {
  zone_id = var.cloudflare_zone_id
}

resource "cloudflare_record" "subdomain_a_record" {
  zone_id = var.cloudflare_zone_id
  type    = local.is_a_record ? "A" : "CNAME"
  ttl     = 1
  name    = var.subdomain
  value   = var.destination
  proxied = true
}

resource "cloudflare_record" "wildcard_subdomain_a_record" {
  count   = var.subdomain != "*" ? 1 : 0
  zone_id = var.cloudflare_zone_id
  type    = local.is_a_record ? "A" : "CNAME"
  ttl     = 1
  name    = local.wildcard
  value   = var.destination
  proxied = true
}

#  Edge Certificate for vanityDomain
resource "cloudflare_certificate_pack" "internal_domain_cert_pack" {
  zone_id = var.cloudflare_zone_id
  type    = "advanced"
  hosts = concat([
    "${data.cloudflare_zone.zone.name}",
    "${local.wildcard}.${data.cloudflare_zone.zone.name}"
  ], var.additional_hosts)
  validation_method      = local.validation_methods[var.certificate_pack_certificate_authority]
  validity_days          = 90
  certificate_authority  = var.certificate_pack_certificate_authority
  cloudflare_branding    = false
  wait_for_active_status = true

  lifecycle {
    create_before_destroy = true
  }
}
