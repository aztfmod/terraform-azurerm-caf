# Azure Virtual Network Gateway

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_virtual_network_gateways" {
  source  = "aztfmod/caf/azurerm//modules/networking/virtual_network_gateways"
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
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostics | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| public\_ip\_addresses | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| vnets | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->