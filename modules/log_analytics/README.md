# Azure Log Analytics Workspace

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_log_analytics" {
  source  = "aztfmod/caf/azurerm//modules/log_analytics"
  version = "4.21.2"
  # insert the 4 required variables here
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
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| log\_analytics | n/a | `any` | n/a | yes |
| resource\_groups | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| location | n/a |
| name | n/a |
| resource\_group\_name | n/a |
| workspace\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->