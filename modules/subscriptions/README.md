# Azure Subscription diagnostics
This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_subscriptions" {
  source  = "aztfmod/caf/azurerm//modules/subscriptions"
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
| diagnostics | For diagnostics settings | `map` | `{}` | no |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| primary\_subscription\_id | n/a | `any` | n/a | yes |
| subscription | n/a | `any` | n/a | yes |
| subscription\_key | n/a | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->