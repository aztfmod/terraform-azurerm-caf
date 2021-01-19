# Azure AD Groups members

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_groups_members" {
  source  = "aztfmod/caf/azurerm//modules/azuread/groups_members"
  version = "4.21.2"
  # insert the 2 required variables here
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
| azuread\_apps | n/a | `map` | `{}` | no |
| azuread\_groups | n/a | `map` | `{}` | no |
| group\_id | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->