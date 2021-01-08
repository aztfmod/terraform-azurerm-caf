# Azure AD Groups

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_groups" {
  source  = "aztfmod/caf/azurerm//modules/azuread/groups"
  version = "4.21.2"
  # insert the 3 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azuread | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azuread\_groups | Set of groups to be created. | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| tenant\_id | The tenant ID of the Azure AD environment where to create the groups. | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | The ID of the group created. |
| name | The name of the group created. |
| rbac\_id | This attribute is used to set the role assignment. |
| tenant\_id | The tenand\_id of the group created. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->