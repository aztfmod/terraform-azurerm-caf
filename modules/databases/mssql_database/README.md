# Azure MS SQL Database

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_mssql_database" {
  source  = "aztfmod/caf/azurerm//modules/databases/mssql_database"
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| elastic\_pool\_id | n/a | `any` | `null` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| server\_id | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| storage\_accounts | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->