# Azure Public IP Address

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_public_ip_addresses" {
  source  = "aztfmod/caf/azurerm//modules/networking/public_ip_addresses"
  version = "4.21.2"
  # insert the 9 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| allocation\_method | n/a | `string` | `"Dynamic"` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| diagnostic\_profiles | n/a | `map` | `{}` | no |
| diagnostics | n/a | `map` | `{}` | no |
| domain\_name\_label | n/a | `any` | `null` | no |
| idle\_timeout\_in\_minutes | n/a | `any` | `null` | no |
| ip\_version | n/a | `string` | `"IPv4"` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| name | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| reverse\_fqdn | n/a | `any` | `null` | no |
| sku | n/a | `string` | `"Basic"` | no |
| tags | n/a | `any` | `null` | no |
| zones | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| fqdn | n/a |
| id | n/a |
| ip\_address | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->