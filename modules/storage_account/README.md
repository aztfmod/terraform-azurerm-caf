# Azure Storage account
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_storage_account" {
  source  = "aztfmod/caf/azurerm//modules/storage_account"
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
| base\_tags | n/a | `map` | `{}` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| private\_endpoints | n/a | `map` | `{}` | no |
| recovery\_vaults | n/a | `map` | `{}` | no |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| resource\_groups | n/a | `map` | `{}` | no |
| storage\_account | n/a | `any` | n/a | yes |
| vnets | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| containers | n/a |
| data\_lake\_filesystems | n/a |
| id | n/a |
| location | n/a |
| name | n/a |
| primary\_blob\_endpoint | n/a |
| resource\_group\_name | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->