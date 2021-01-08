# Azure Virtual Network

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_virtual_network" {
  source  = "aztfmod/caf/azurerm//modules/networking/virtual_network"
  version = "4.21.2"
  # insert the 8 required variables here
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
| ddos\_id | (Optional) ID of the DDoS protection plan if exists | `string` | `""` | no |
| diagnostics | (Required) Diagnostics object with the definitions and destination services | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the Azure location to deploy the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| netwatcher | (Optional) is a map with two attributes: name, rg who describes the name and rg where the netwatcher was already deployed | `map` | `{}` | no |
| network\_security\_group\_definition | n/a | `any` | n/a | yes |
| network\_watchers | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) Name of the resource group where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| route\_tables | n/a | `map` | `{}` | no |
| settings | (Required) configuration object describing the networking configuration, as described in README | `any` | n/a | yes |
| tags | (Required) map of tags for the deployment | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| address\_space | Virutal Network address\_space |
| dns\_servers | Virutal Network dns\_servers |
| id | Virutal Network id |
| location | Azure region of the virtual network |
| name | Virutal Network name |
| resource\_group\_name | Virutal Network resource\_group\_name |
| subnets | Returns all the subnets objects in the Virtual Network. As a map of keys, ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->