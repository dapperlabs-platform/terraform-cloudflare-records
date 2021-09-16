output "key" {
  description = "Certificate key"
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
}
output "certificate" {
  description = "The Origin CA certificate"
  value       = cloudflare_origin_ca_certificate.origin_certificate.certificate
  sensitive   = true
}
