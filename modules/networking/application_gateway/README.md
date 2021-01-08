# Azure Application Gateway

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_application_gateway" {
  source  = "aztfmod/caf/azurerm//modules/networking/application_gateway"
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
| app\_services | n/a | `map` | `{}` | no |
| application\_gateway\_applications | n/a | `any` | n/a | yes |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostics | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| keyvault\_certificates | n/a | `map` | `{}` | no |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| managed\_identities | n/a | `map` | `{}` | no |
| private\_dns | n/a | `map` | `{}` | no |
| public\_ip\_addresses | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| sku\_name | (Optional) (Default = Standard\_v2) The Name of the SKU to use for this Application Gateway. Possible values are Standard\_Small, Standard\_Medium, Standard\_Large, Standard\_v2, WAF\_Medium, WAF\_Large, and WAF\_v2. | `string` | `"Standard_v2"` | no |
| sku\_tier | (Optional) (Default = Standard\_v2) (Required) The Tier of the SKU to use for this Application Gateway. Possible values are Standard, Standard\_v2, WAF and WAF\_v2. | `string` | `"Standard_v2"` | no |
| vnets | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| private\_ip\_address | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->