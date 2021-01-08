# Azure AD Applications

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_applications" {
  source  = "aztfmod/caf/azurerm//modules/azuread/applications"
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
| azurerm | n/a |
| null | n/a |
| random | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| azuread\_api\_permissions | n/a | `map` | `{}` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | n/a | `map` | `{}` | no |
| keyvaults | n/a | `map` | `{}` | no |
| settings | n/a | `map` | `{}` | no |
| user\_type | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| azuread\_application | n/a |
| azuread\_service\_principal | n/a |
| keyvaults | n/a |
| rbac\_id | This attribute is used to set the role assignment |
| tenant\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->