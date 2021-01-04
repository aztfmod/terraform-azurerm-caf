# Azure Key Vault Certificate Request

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_keyvault_certificate_request" {
  source  = "aztfmod/caf/azurerm//modules/security/keyvault_certificate_request"
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
| certificate\_issuers | n/a | `map` | `{}` | no |
| keyvault\_id | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| certificate\_attribute | n/a |
| certificate\_data | n/a |
| id | n/a |
| secret\_id | n/a |
| thumbprint | n/a |
| version | n/a |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->