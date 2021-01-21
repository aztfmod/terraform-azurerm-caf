# Azure Private Endpoint

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_private_endpoint" {
  source  = "aztfmod/caf/azurerm//modules/networking/private_endpoint"
  version = "4.21.2"
  # insert the 8 required variables here
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
| location | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| name | (Required) Specifies the name. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group. Changing this forces a new resource to be created. | `any` | n/a | yes |
| resource\_id | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| subnet\_id | n/a | `any` | n/a | yes |
| subresource\_names | n/a | `list` | `[]` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| private\_dns | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| private\_dns\_zone\_configs | n/a |
| private\_dns\_zone\_group | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->