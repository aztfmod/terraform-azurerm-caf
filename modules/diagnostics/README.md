# Diagnostic settings for Azure resources

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_diagnostics" {
  source  = "aztfmod/caf/azurerm//modules/diagnostics"
  version = "4.21.2"
  # insert the 4 required variables here
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
| diagnostics | (Required) Contains the diagnostics setting object. | `any` | n/a | yes |
| global\_settings | n/a | `map` | `{}` | no |
| profiles | n/a | `any` | n/a | yes |
| resource\_id | (Required) Fully qualified Azure resource identifier for which you enable diagnostics. | `any` | n/a | yes |
| resource\_location | (Required) location of the resource | `any` | n/a | yes |

## Outputs

No output.

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->