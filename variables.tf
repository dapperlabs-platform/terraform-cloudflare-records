variable "destination_ip" {
  description = "Your destination IP (Load balancer)"
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
