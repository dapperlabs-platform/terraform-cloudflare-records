variable "vanity_domain" {
  description = "Public Facing Domain"
  type        = string
}

variable "internal_subdomain" {
  description = "Internal Sub Domain"
  type        = string
}

variable "k8s_ingress_ip" {
  description = "Load Balancer IP"
  type        = string
}

variable "common_name" {
  default = "Some Common Name"
  type    = string
}

variable "organization" {
  default = "Some Organization"
  type    = string
}
