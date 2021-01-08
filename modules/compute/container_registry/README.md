# Azure Container Registry

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_container_registry" {
  source  = "aztfmod/caf/azurerm//modules/compute/container_registry"
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
| admin\_enabled | (Optional) Specifies whether the admin user is enabled. Defaults to false. | `bool` | `false` | no |
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| diagnostic\_profiles | n/a | `map` | `{}` | no |
| diagnostics | n/a | `map` | `{}` | no |
| georeplication\_locations | (Optional) A list of Azure locations where the container registry should be geo-replicated. | `any` | `null` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| name | (Required) Specifies the name of the Container Registry. Changing this forces a new resource to be created. | `string` | n/a | yes |
| network\_rule\_set | (Optional) A network\_rule\_set block as documented https://www.terraform.io/docs/providers/azurerm/r/container_registry.html | `map` | `{}` | no |
| private\_endpoints | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) The name of the resource group in which to create the Container Registry. Changing this forces a new resource to be created. | `any` | n/a | yes |
| resource\_groups | n/a | `map` | `{}` | no |
| sku | (Optional) The SKU name of the container registry. Possible values are Basic, Standard and Premium. Defaults to Basic | `string` | `"Basic"` | no |
| tags | (Optional) A mapping of tags to assign to the resource. | `map` | `{}` | no |
| vnets | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |
| login\_server | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->