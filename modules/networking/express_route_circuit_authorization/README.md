# Azure Express Route Circuit Authorization

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_express_route_circuit_authorization" {
  source  = "aztfmod/caf/azurerm//modules/networking/express_route_circuit_authorization"
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
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| express\_route\_circuit\_name | n/a | `any` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| authorization\_key | The authorization key |
| authorization\_use\_status | The authorization use status. |
| id | Express Route Circuit Authorization ID |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->