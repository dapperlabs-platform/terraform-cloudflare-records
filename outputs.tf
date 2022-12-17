output "key" {
  description = "Certificate key"
  value       = tls_private_key.private_key.private_key_pem
  sensitive   = true
}
