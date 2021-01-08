# Azure Express Route Circuit

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_express_route_circuit" {
  source  = "aztfmod/caf/azurerm//modules/networking/express_route_circuit"
  version = "4.21.2"
  # insert the 6 required variables here
}
```

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| azurecaf | n/a |
| azurerm | n/a |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| diagnostics | n/a | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | (Required) Specifies the supported Azure location where to create the resource. Changing this forces a new resource to be created. | `string` | n/a | yes |
| resource\_group\_name | (Required) The name of the resource group where to create the resource. | `string` | n/a | yes |
| resource\_groups | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| id | Express Route Circuit ID |
| name | Name of the Express Route Circuit. |
| resource\_group\_name | The Express Route circuit resource group name. |
| service\_key | The string needed by the service provider to provision the ExpressRoute circuit. |
| service\_provider\_provisioning\_state | The ExpressRoute circuit provisioning state from your chosen service provider. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->