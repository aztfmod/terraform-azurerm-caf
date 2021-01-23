# Azure Availability Set

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_availability_set" {
  source  = "aztfmod/caf/azurerm//modules/compute/availability_set"
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
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| availability\_sets | n/a | `any` | n/a | yes |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| name | n/a | `any` | n/a | yes |
| ppg\_id | n/a | `any` | n/a | yes |
| proximity\_placement\_groups | n/a | `any` | n/a | yes |
| resource\_group\_name | Name of the existing resource group to deploy the virtual machine | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| tags | n/a | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->