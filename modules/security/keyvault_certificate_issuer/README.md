# Azure Key Vault Certificate Issuer

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_keyvault_certificate_issuer" {
  source  = "aztfmod/caf/azurerm//modules/security/keyvault_certificate_issuer"
  version = "4.21.2"
  # insert the 11 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13 |

## Providers

| Name | Version |
|------|---------|
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_id | n/a | `any` | `null` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| issuer\_name | n/a | `any` | `null` | no |
| keyvault\_id | n/a | `any` | `null` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| organization\_id | n/a | `any` | `null` | no |
| password | n/a | `any` | n/a | yes |
| provider\_name | n/a | `any` | `null` | no |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->