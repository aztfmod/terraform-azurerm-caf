# Azure Firewall - Network Rule Collections

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_firewall_network_rule_collections" {
  source  = "aztfmod/caf/azurerm//modules/networking/firewall_network_rule_collections"
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

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azure\_firewall\_name | (Required) Specifies the name of the Firewall in which the Network Rule Collection should be created. Changing this forces a new resource to be created. | `any` | n/a | yes |
| azurerm\_firewall\_network\_rule\_collection\_definition | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| resource\_group\_name | (Required) Specifies the name of the Resource Group in which the Firewall exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| rule\_collections | (Required) One or more rules as defined https://www.terraform.io/docs/providers/azurerm/r/firewall_network_rule_collection.html | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->