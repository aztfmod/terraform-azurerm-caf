# Azure Route

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_routes" {
  source  = "aztfmod/caf/azurerm//modules/networking/routes"
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
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| address\_prefix | n/a | `any` | n/a | yes |
| name | n/a | `any` | n/a | yes |
| next\_hop\_in\_ip\_address | n/a | `any` | `null` | no |
| next\_hop\_in\_ip\_address\_fw | n/a | `any` | `null` | no |
| next\_hop\_in\_ip\_address\_vm | n/a | `any` | `null` | no |
| next\_hop\_type | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| route\_table\_name | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->