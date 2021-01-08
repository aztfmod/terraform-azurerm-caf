# Azure Role Assignment
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_custom_roles" {
  source  = "aztfmod/caf/azurerm//modules/roles/custom_roles"
  version = "4.21.2"
  # insert the 3 required variables here
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
| azuread\_apps | n/a | `map` | `{}` | no |
| azuread\_groups | n/a | `map` | `{}` | no |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| custom\_roles | n/a | `map` | `{}` | no |
| managed\_identities | n/a | `map` | `{}` | no |
| mode | n/a | `any` | n/a | yes |
| object\_id | n/a | `map` | `{}` | no |
| role\_mappings | n/a | `any` | n/a | yes |
| scope | n/a | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->