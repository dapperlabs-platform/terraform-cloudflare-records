# Cloudflare Module

[`Cloudflare Provider`](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs) provides access to Cloudflare configurations via terraform.

This module creates:

- A Record that points \*.internalSubdomain to the ingress IP
- A record that points vanityDomain to the ingress IP
- An Edge Certificate for internalDomain, \*.internalDomain

## Usage

```hcl
# This is used internally in the gke-cluster module (main.tf)
module "demo_dapperlabs_com" {
  source             = "github.com/dapperlabs-platform/terraform-cloudflare-records?ref=tag"
  internal_subdomain = "app.domain.com"
  k8s_ingress_ip     = "X.X.X.X"
  vanity_domain      = "fancydomain.com"
}
```

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
