# Azure DNS domain zone

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_dns_zone" {
  source  = "aztfmod/caf/azurerm//modules/networking/dns_zone"
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
| azurerm | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| dns\_zone\_id | DNS Zone resource ID |
| dns\_zone\_name | DNS Zone name |
| dns\_zone\_object | DNS Zone resource object |
| domain\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->