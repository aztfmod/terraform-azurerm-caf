# Azure MS SQL Managed Database

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_mssql_managed_database" {
  source  = "aztfmod/caf/azurerm//modules/databases/mssql_managed_database"
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
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| server\_name | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| sourceDatabaseId | n/a | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | SQL Managed DB Id |
| name | SQL Managed DB Name |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->