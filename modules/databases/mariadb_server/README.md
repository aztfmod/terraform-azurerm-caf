# Azure Maria DB Server

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_maria_db_server" {
  source  = "aztfmod/caf/azurerm//modules/databases/mariadb_server"
  version = "4.21.2"
  # insert the 5 required variables here
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
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azuread\_groups | n/a | `any` | n/a | yes |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| diagnostic\_profiles | n/a | `any` | `null` | no |
| diagnostics | n/a | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvault\_id | n/a | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| private\_endpoints | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| resource\_groups | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| storage\_accounts | n/a | `any` | n/a | yes |
| subnet\_id | n/a | `any` | n/a | yes |
| vnets | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| location | n/a |
| name | n/a |
| resource\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->