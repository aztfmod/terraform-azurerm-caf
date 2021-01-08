# Azure Front Door

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_front_door" {
  source  = "aztfmod/caf/azurerm//modules/networking/front_door"
  version = "4.21.2"
  # insert the 6 required variables here
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
| azuread | n/a |
| azurecaf | n/a |
| azurerm | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostics | n/a | `any` | n/a | yes |
| front\_door\_waf\_policies | n/a | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvault\_id | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| tags | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| frontend\_endpoints | n/a |
| id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->