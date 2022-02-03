## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.egdt](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventgrid_domain_topic.egdt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object (see module README.md). | `any` | n/a | yes |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | Required) Specifies the name of the EventGrid Domain. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object (see module README.md) | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the EventGrid Domain Topic resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created. | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the EventGrid Domain Topic. |
