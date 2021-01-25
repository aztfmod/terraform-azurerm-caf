# Azure Firewall

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_firewall" {
  source  = "aztfmod/caf/azurerm//modules/networking/firewall"
  version = "4.21.2"
  # insert the 9 required variables here
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
| diagnostic\_profiles | n/a | `map` | `{}` | no |
| diagnostics | n/a | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Location of the Azure Firewall to be created | `any` | n/a | yes |
| name | (Required) Name of the Azure Firewall to be created | `any` | n/a | yes |
| public\_ip\_id | (Required) Public IP address identifier. IP address must be of type static and standard. | `any` | n/a | yes |
| resource\_group\_name | (Required) Resource Group of the Azure Firewall to be created | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| subnet\_id | (Required) ID for the subnet where to deploy the Azure Firewall | `any` | n/a | yes |
| tags | (Required) Tags of the Azure Firewall to be created | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the Azure Firewall. |
| ip\_configuration | The Private IP address of the Azure Firewall. |
| name | Name of the firewall |
| resource\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->