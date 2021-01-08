# Azure Synapse Workspace

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_synapse" {
  source  = "aztfmod/caf/azurerm//modules/analytics/synapse"
  version = "4.21.2"
  # insert the 7 required variables here
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
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvault\_id | The ID of the Key Vault to be used by the Synapse workspace. | `string` | `null` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | Configuration object for the Synapse workspace. | `any` | n/a | yes |
| storage\_data\_lake\_gen2\_filesystem\_id | The ID of the Datalake filesystem to be used by Synapse. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| connectivity\_endpoints | A list of Connectivity endpoints for this Synapse Workspace. |
| id | The ID of the Synapse Workspace. |
| identity | An identity block which contains the Managed Service Identity information for this Synapse Workspace. - type - The Identity Type for the Service Principal associated with the Managed Service Identity of this Synapse Workspace. principal\_id - The Principal ID for the Service Principal associated with the Managed Service Identity of this Synapse Workspace. tenant\_id - The Tenant ID for the Service Principal associated with the Managed Service Identity of this Synapse Workspace. |
| managed\_resource\_group\_name | Workspace managed resource group. |
| rbac\_id | n/a |
| spark\_pool | Spark pool object |
| sql\_pool | SQL pool object |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->