# Azure Key Vault Certificate

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_keyvault_certificate" {
  source  = "aztfmod/caf/azurerm//modules/security/keyvault_certificate"
  version = "4.21.2"
  # insert the 2 required variables here
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
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| keyvault | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| secret\_id | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->