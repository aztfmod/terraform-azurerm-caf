# Azure Key Vault Access Policies

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_keyvault_access_policies" {
  source  = "aztfmod/caf/azurerm//modules/security/keyvault_access_policies"
  version = "4.21.2"
  # insert the 4 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

No provider.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| access\_policies | n/a | `any` | n/a | yes |
| azuread\_apps | n/a | `map` | `{}` | no |
| azuread\_groups | n/a | `map` | `{}` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| keyvault\_id | n/a | `any` | `null` | no |
| keyvault\_key | n/a | `any` | `null` | no |
| keyvaults | n/a | `map` | `{}` | no |
| managed\_identities | n/a | `map` | `{}` | no |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->