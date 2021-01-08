# Azure App Service Environment
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_ase" {
  source  = "aztfmod/caf/azurerm//modules/webapps/ase"
  version = "4.21.2"
  # insert the 14 required variables here
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
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| diagnostic\_profiles | n/a | `any` | `null` | no |
| diagnostics | n/a | `any` | `null` | no |
| front\_end\_count | Number of instances in the front-end pool.  Minimum of two. | `string` | `"2"` | no |
| front\_end\_size | Instance size for the front-end pool. | `string` | `"Standard_D1_V2"` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| internalLoadBalancingMode | n/a | `any` | n/a | yes |
| kind | (Required) Kind of resource. Possible value are ASEV2 | `any` | n/a | yes |
| location | (Required) Resource Location | `any` | n/a | yes |
| name | (Required) Name of the App Service Environment | `any` | n/a | yes |
| private\_dns | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) Resource group of the ASE | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| subnet\_id | (Required) Name of the Virtual Network for the ASE | `any` | n/a | yes |
| subnet\_name | n/a | `any` | n/a | yes |
| tags | (Required) map of tags for the deployment | `any` | n/a | yes |
| zone | (Required) Availability Zone of resource. Possible value are 1, 2 or 3 | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| a\_records | n/a |
| id | App Service Environment Resource Id |
| ilb\_ip | n/a |
| name | App Service Environment Name |
| subnet\_id | n/a |
| zone | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->