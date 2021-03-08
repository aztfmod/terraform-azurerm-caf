# Azure DevOps

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "azure_devops_projects" {
  source  = "aztfmod/caf/azurerm//modules/devops/providers/azure-devops"
  version = "5.1.3"
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
| microsoft/azuredevops | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| project | The project configuration map | `map` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The Project ID. |
| name | The Project name. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->