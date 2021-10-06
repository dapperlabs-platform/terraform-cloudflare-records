# Cloudflare Module

[`Cloudflare Provider`](https://registry.terraform.io/providers/cloudflare/cloudflare/latest/docs) provides access to Cloudflare configurations via terraform.

This module creates:

- A/CNAME Record that points `subdomain.cloudflare_zone_domain` to the destination
- A/CNAME Record that points `*.subdomain.cloudflare_zone_domain` to the destination
- An Edge Certificate for `subdomain.cloudflare_zone_domain`, `*.subdomain.cloudflare_zone_domain`
- An Origin Certificate for `subdomain.cloudflare_zone_domain`, `*.subdomain.cloudflare_zone_domain`
## Usage

```hcl
# This is used internally in the gke-cluster module (main.tf)
module "cloudflare-records" {
  source                 = "github.com/dapperlabs-platform/terraform-cloudflare-records?ref=tag"
  cloudflare_zone_domain = "zone.com"
  destination            = "1.2.3.4"
  subdomain              = "app.zone.com"
}
```
