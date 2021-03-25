# Azure Event Hub Namespace

This submodule is part of Cloud Adoption Framework landing zones for Azure on Terraform.

You can instantiate this submodule directly using the following parameters:

```
module "caf_event_hub_namespaces" {
  source  = "aztfmod/caf/azurerm//modules/event_hub_namespaces"
  version = "4.21.2"
  # insert the 5 required variables here
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
| azurecaf | n/a |
| azurerm | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| event_hub_namespace_auth_rules | ./auth_rules |  |
| event_hubs | ../hubs |  |

## Resources

| Name |
|------|
| [azurecaf_name](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) |
| [azurerm_eventhub_namespace](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_namespace) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| base\_tags | Base tags for the resource to be inherited from the resource group. | `map(any)` | n/a | yes |
| client\_config | Client configuration object (see module README.md). | `any` | n/a | yes |
| global\_settings | Global settings object (see module README.md) | `any` | n/a | yes |
| location | n/a | `any` | n/a | yes |
| resource\_group\_name | n/a | `any` | n/a | yes |
| settings | n/a | `any` | n/a | yes |
| storage\_accounts | n/a | `map` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| id | The EventHub Namespace ID. |
| location | Location of the service |
| name | The EventHub Namespace name. |
| resource\_group\_name | Name of the resource group |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->