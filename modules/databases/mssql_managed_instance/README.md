# Azure MS SQL Managed Instance

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_mssql_managed_instance" {
  source  = "aztfmod/caf/azurerm//modules/databases/mssql_managed_instance"
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
| azurecaf | n/a |
| azurerm | n/a |
| null | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| primary\_server\_id | n/a | `string` | `""` | no |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| subnet\_id | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | SQL MI Id |
| location | n/a |
| name | SQL MI Name |
| principal\_id | SQL MI Identity Principal Id |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->