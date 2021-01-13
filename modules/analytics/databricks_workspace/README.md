# Azure Databricks Workspace

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_databricks_workspace" {
  source  = "aztfmod/caf/azurerm//modules/analytics/databricks_workspace"
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | Configuration object for the Databricks workspace. | `any` | n/a | yes |
| vnets | Virtual networks objects - contains all virtual networks that could potentially be used by the module. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Databricks Workspace in the Azure management plane. |
| managed\_resource\_group\_id | The ID of the Managed Resource Group created by the Databricks Workspace. |
| workspace\_id | The unique identifier of the databricks workspace in Databricks control plane. |
| workspace\_url | The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net' |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->