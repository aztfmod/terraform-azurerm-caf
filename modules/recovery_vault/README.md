# Azure Site Recovery Vault

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_recovery_vault" {
  source  = "aztfmod/caf/azurerm//modules/recovery_vault"
  version = "4.21.2"
  # insert the 11 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |
| time | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostics | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| identity | n/a | `any` | `null` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| private\_dns | n/a | `map` | `{}` | no |
| private\_endpoints | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| resource\_groups | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| vnets | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| backup\_policies | Output the set of backup policies in this vault |
| id | Output the object ID |
| name | Output the object name |
| replication\_policies | Ouput the set of replication policies in the vault |
| resource\_group\_name | Output the resource group name |
| soft\_delete\_enabled | Boolean indicating if soft deleted is enabled on the vault. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->