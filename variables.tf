variable "destination" {
  description = "Your destination IP for A or subdomain for CNAME records"
  type        = string
}

variable "cloudflare_zone_domain" {
  description = "Main cloudflare zone to create records and certificates in"
}

variable "subdomain" {
  description = "Subdomain to create records and certificates for"
  type        = string
  default     = "*"
}

variable "certificate_pack_certificate_authority" {
  description = "Certificate authority for the advanced certificate pack. Allowed values are google and lets_encrypt"
  type        = string
  default     = "google"
  validation {
    condition     = contains(["google", "lets_encrypt"], var.certificate_pack_certificate_authority)
    error_message = "The certificate_pack_certificate_authority value must be google or lets_encrypt."
  }
}
