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
| <a name="module_private_endpoint"></a> [private\_endpoint](#module\_private\_endpoint) | ../../../networking/private_endpoint |  |

## Resources

| Name | Type |
|------|------|
| [azurecaf_name.egt](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventgrid_topic.egt](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_topic) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_base_tags"></a> [base\_tags](#input\_base\_tags) | (Optional)Base tags for the resource to be inherited from the resource group. | `map(any)` | `{}` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object (see module README.md). | `any` | `null` | no |
| <a name="input_combined_objects"></a> [combined\_objects](#input\_combined\_objects) | n/a | `map` | `{}` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object (see module README.md) | `any` | `null` | no |
| <a name="input_identity"></a> [identity](#input\_identity) | A identity block supports the following:<br>  type - Specifies the type of Managed Service Identity that is configured on this Event Grid Topic.<br>  principal\_id - Specifies the Principal ID of the System Assigned Managed Service Identity that is configured on this Event Grid Topic.<br>  tenant\_id - Specifies the Tenant ID of the System Assigned Managed Service Identity that is configured on this Event Grid Topic.<br>  identity\_ids - A list of IDs for User Assigned Managed Identity resources to be assigned. | `any` | `null` | no |
| <a name="input_inbound_ip_rule"></a> [inbound\_ip\_rule](#input\_inbound\_ip\_rule) | A inbound\_ip\_rule block supports the following:<br>  ip\_mask - (Required) The ip mask (CIDR) to match on.<br>  action - (Optional) The action to take when the rule is matched. Possible values are Allow. | `any` | `null` | no |
| <a name="input_input_mapping_default_values"></a> [input\_mapping\_default\_values](#input\_input\_mapping\_default\_values) | input\_mapping\_default\_values supports the following:<br>  event\_type - (Optional) Specifies the default event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  data\_version - (Optional) Specifies the default data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  subject - (Optional) Specifies the default subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_input_mapping_fields"></a> [input\_mapping\_fields](#input\_input\_mapping\_fields) | input\_mapping\_fields supports the following:<br>  id - (Optional) Specifies the id of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  topic - (Optional) Specifies the topic of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  event\_type - (Optional) Specifies the event type of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  event\_time - (Optional) Specifies the event time of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  data\_version - (Optional) Specifies the data version of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created.<br>  subject - (Optional) Specifies the subject of the EventGrid Event to associate with the domain. Changing this forces a new resource to be created. | `any` | `null` | no |
| <a name="input_input_schema"></a> [input\_schema](#input\_input\_schema) | (Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1\_0, CustomEventSchema, or EventGridSchema | `string` | `"EventGridSchema"` | no |
| <a name="input_local_auth_enabled"></a> [local\_auth\_enabled](#input\_local\_auth\_enabled) | (Optional) Whether local authentication methods is enabled for the EventGrid Domain. | `bool` | `true` | no |
| <a name="input_location"></a> [location](#input\_location) | (Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the EventGrid Topic resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_private_dns"></a> [private\_dns](#input\_private\_dns) | n/a | `map` | `{}` | no |
| <a name="input_private_endpoints"></a> [private\_endpoints](#input\_private\_endpoints) | n/a | `any` | n/a | yes |
| <a name="input_public_network_access_enabled"></a> [public\_network\_access\_enabled](#input\_public\_network\_access\_enabled) | (Optional) Whether or not public network access is allowed for this server. | `bool` | `true` | no |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | n/a | `any` | `null` | no |
| <a name="input_resource_group_name"></a> [resource\_group\_name](#input\_resource\_group\_name) | (Required) The name of the resource group in which the EventGrid Topic exists. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_resource_groups"></a> [resource\_groups](#input\_resource\_groups) | n/a | `any` | n/a | yes |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | n/a | `any` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | (Optional) map of tags for the EventGrid Topic | `map(any)` | `{}` | no |
| <a name="input_vnets"></a> [vnets](#input\_vnets) | n/a | `any` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_endpoint"></a> [endpoint](#output\_endpoint) | The Endpoint associated with the EventGrid Domain. |
| <a name="output_id"></a> [id](#output\_id) | The ID of the EventGrid Domain. |
| <a name="output_identity"></a> [identity](#output\_identity) | All outputs of block identity. |
| <a name="output_identity_ids"></a> [identity\_ids](#output\_identity\_ids) | A list of IDs for User Assigned Managed Identity resources to be assigned. |
| <a name="output_identity_principal_id"></a> [identity\_principal\_id](#output\_identity\_principal\_id) | Specifies the Principal ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain. |
| <a name="output_identity_type"></a> [identity\_type](#output\_identity\_type) | Specifies the type of Managed Service Identity that is configured on this Event Grid Domain. |
| <a name="output_name"></a> [name](#output\_name) | The Name of the EventGrid Domain. |
| <a name="output_primary_access_key"></a> [primary\_access\_key](#output\_primary\_access\_key) | The Primary Shared Access Key associated with the EventGrid Domain. |
| <a name="output_secondary_access_key"></a> [secondary\_access\_key](#output\_secondary\_access\_key) | The Secondary Shared Access Key associated with the EventGrid Domain. |
| <a name="output_tenant_id"></a> [tenant\_id](#output\_tenant\_id) | Specifies the Tenant ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain. |
