## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurecaf"></a> [azurecaf](#provider\_azurecaf) | n/a |
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_eventgrid_domain_topics"></a> [eventgrid\_domain\_topics](#module\_eventgrid\_domain\_topics) | ../eventgrid_domain_topic |  |
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | ../../../networking/private_endpoint |  |

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.egd](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventgrid_domain.egd](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_domain) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_auto_create_topic_with_first_subscription"></a> [auto\_create\_topic\_with\_first\_subscription](#input\_auto\_create\_topic\_with\_first\_subscription) | (Optional) Whether local authentication methods is enabled for the EventGrid Domain. | `bool` | `true` | no |
| <a name="input_auto_delete_topic_with_last_subscription"></a> [auto\_delete\_topic\_with\_last\_subscription](#input\_auto\_delete\_topic\_with\_last\_subscription) | (Optional) Whether local authentication methods is enabled for the EventGrid Domain. | `bool` | `true` | no |
| <a name="input_base_tags"></a> [base\_tags](#input\_base\_tags) | Base tags for the resource to be inherited from the resource group. | `map(any)` | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object (see module README.md). | `any` | n/a | yes |
| <a name="input_combined_objects"></a> [combined\_objects](#input\_combined\_objects) | n/a | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object (see module README.md) | `any` | n/a | yes |
| <a name="input_identity"></a> [identity](#input\_identity) | n/a | `any` | `null` | no |
| <a name="input_inbound_ip_rule"></a> [inbound\_ip\_rule](#input\_inbound\_ip\_rule) | n/a | `map` | `{}` | no |
| <a name="input_input_mapping_fields"></a> [input\_mapping\_fields](#input\_input\_mapping\_fields) | n/a | `any` | `null` | no |
| <a name="input_input_schema"></a> [input\_schema](#input\_input\_schema) | (Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1\_0, CustomEventSchema, or EventGridSchema | `string` | `"EventGridSchema"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | (Optional) Whether local authentication methods is enabled for the EventGrid Domain. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Resource Location | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the EventGrid Domain resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | n/a | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | n/a | `any` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether or not public network access is allowed for this server. | `bool` | `true` | no |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | n/a | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which the EventGrid Domain exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Required) map of tags for the EventGrid Domain | `any` | n/a | yes |
| <a name="input_vnets"></a> [vnets](#input\_vnets) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The Endpoint associated with the EventGrid Domain. |
| <a name="output_eventgrid_domain_topics"></a> [eventgrid\_domain\_topics](#output\_eventgrid\_domain\_topics) | n/a |
| <a name="output_id"></a> [id](#output\_id) | The ID of the EventGrid Domain. |
| <a name="output_identity"></a> [identity](#output\_identity) | All outputs of block identity. |
| <a name="output_identity_ids"></a> [identity\_ids](#output\_identity\_ids) | A list of IDs for User Assigned Managed Identity resources to be assigned. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | Specifies the Principal ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain. |
| <a name="output_identity_type"></a> [identity\_type](#output\_identity\_type) | Specifies the type of Managed Service Identity that is configured on this Event Grid Domain. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the EventGrid Domain. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Shared Access Key associated with the EventGrid Domain. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The Secondary Shared Access Key associated with the EventGrid Domain. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | Specifies the Tenant ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain. |
