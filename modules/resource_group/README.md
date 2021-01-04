# Azure Resource group
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_resource_group" {
  source  = "aztfmod/caf/azurerm//modules/resource_group"
  version = "4.21.2"
  # insert the 4 required variables here
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
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| tags | (Required) Map of tags to be applied to the resource | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| location | n/a |
| name | n/a |
| rbac\_id | n/a |
| tags | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->