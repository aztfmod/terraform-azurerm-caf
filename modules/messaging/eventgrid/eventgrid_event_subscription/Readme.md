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
| [azurecaf_name.egs](https://registry.terraform.io/providers/aztfmod/azurecaf/latest/docs/resources/name) | resource |
| [azurerm_eventgrid_event_subscription.egs](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_advanced_filter"></a> [advanced\_filter](#input\_advanced\_filter) | (Optional) A advanced\_filter block as defined below<br>   A advanced\_filter supports the following nested blocks:<br>   bool\_equals - Compares a value of an event using a single boolean value.<br>   number\_greater\_than - Compares a value of an event using a single floating point number.<br>   number\_greater\_than\_or\_equals - Compares a value of an event using a single floating point number.<br>   number\_less\_than - Compares a value of an event using a single floating point number.<br>   number\_less\_than\_or\_equals - Compares a value of an event using a single floating point number.<br>   number\_in - Compares a value of an event using multiple floating point numbers.<br>   number\_not\_in - Compares a value of an event using multiple floating point numbers.<br>   number\_in\_range - Compares a value of an event using multiple floating point number ranges.<br>   number\_not\_in\_range - Compares a value of an event using multiple floating point number ranges.<br>   string\_begins\_with - Compares a value of an event using multiple string values.<br>   string\_not\_begins\_with - Compares a value of an event using multiple string values.<br>   string\_ends\_with - Compares a value of an event using multiple string values.<br>   string\_not\_ends\_with - Compares a value of an event using multiple string values.<br>   string\_contains - Compares a value of an event using multiple string values.<br>   string\_not\_contains - Compares a value of an event using multiple string values.<br>   string\_in - Compares a value of an event using multiple string values.<br>   string\_not\_in - Compares a value of an event using multiple string values.<br>   is\_not\_null - Evaluates if a value of an event isn't NULL or undefined.<br>   is\_null\_or\_undefined - Evaluates if a value of an event is NULL or undefined. | `any` | `null` | no |
| <a name="input_advanced_filtering_on_arrays_enabled"></a> [advanced\_filtering\_on\_arrays\_enabled](#input\_advanced\_filtering\_on\_arrays\_enabled) | (Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false. | `any` | `null` | no |
| <a name="input_azure_function_endpoint"></a> [azure\_function\_endpoint](#input\_azure\_function\_endpoint) | An azure\_function\_endpoint supports the following:<br>  function\_id - (Required) Specifies the ID of the Function where the Event Subscription will receive events. This must be the functions ID in format {function\_app.id}/functions/{name}.<br>  max\_events\_per\_batch - (Optional) Maximum number of events per batch.<br>  preferred\_batch\_size\_in\_kilobytes - (Optional) Preferred batch size in Kilobytes. | `any` | `null` | no |
| <a name="input_client_config"></a> [client\_config](#input\_client\_config) | Client configuration object (see module README.md). | `any` | `null` | no |
| <a name="input_combined_objects"></a> [combined\_objects](#input\_combined\_objects) | n/a | `any` | `null` | no |
| <a name="input_dead_letter_identity"></a> [dead\_letter\_identity](#input\_dead\_letter\_identity) | storage\_blob\_dead\_letter\_destination must be specified when a dead\_letter\_identity is specified<br>  (Optional) A dead\_letter\_identity block as defined below:<br>  type - (Required) Specifies the type of Managed Service Identity that is used for dead lettering. Allowed value is SystemAssigned, UserAssigned.<br>  user\_assigned\_identity - (Optional) The user identity associated with the resource | `any` | `null` | no |
| <a name="input_delivery_identity"></a> [delivery\_identity](#input\_delivery\_identity) | (Optional) A delivery\_identity block as defined below:<br>  type - (Required) Specifies the type of Managed Service Identity that is used for event delivery. Allowed value is SystemAssigned, UserAssigned.<br>  user\_assigned\_identity - (Optional) The user identity associated with the resource. | `any` | `null` | no |
| <a name="input_delivery_property"></a> [delivery\_property](#input\_delivery\_property) | (Optional) A delivery\_property block as defined below:<br>  header\_name - (Required) The name of the header to send on to the destination<br>  type - (Required) Either Static or Dynamic<br>  value - (Optional) If the type is Static, then provide the value to use<br>  source\_field - (Optional) If the type is Dynamic, then provide the payload field to be used as the value. Valid source fields differ by subscription type.<br>  secret - (Optional) True if the value is a secret and should be protected, otherwise false. If True, then this value won't be returned from Azure API calls | `any` | `null` | no |
| <a name="input_event_delivery_schema"></a> [event\_delivery\_schema](#input\_event\_delivery\_schema) | (Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1\_0, CustomEventSchema, or EventGridSchema | `string` | `"EventGridSchema"` | no |
| <a name="input_eventhub_endpoint_id"></a> [eventhub\_endpoint\_id](#input\_eventhub\_endpoint\_id) | (Optional) Specifies the id where the Event Hub is located. | `any` | `null` | no |
| <a name="input_expiration_time_utc"></a> [expiration\_time\_utc](#input\_expiration\_time\_utc) | (Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339). | `any` | `null` | no |
| <a name="input_global_settings"></a> [global\_settings](#input\_global\_settings) | Global settings object (see module README.md) | `any` | `null` | no |
| <a name="input_hybrid_connection_endpoint_id"></a> [hybrid\_connection\_endpoint\_id](#input\_hybrid\_connection\_endpoint\_id) | (Optional) Specifies the id where the Hybrid Connection is located. | `any` | `null` | no |
| <a name="input_included_event_types"></a> [included\_event\_types](#input\_included\_event\_types) | (Optional) A list of applicable event types that need to be part of the event subscription. | `any` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | (Optional) A list of labels to assign to the event subscription. | `any` | `null` | no |
| <a name="input_name"></a> [name](#input\_name) | (Required) Specifies the name of the EventGrid Event Subscription resource. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_remote_objects"></a> [remote\_objects](#input\_remote\_objects) | n/a | `any` | `null` | no |
| <a name="input_retry_policy"></a> [retry\_policy](#input\_retry\_policy) | (Optional) A retry\_policy block as defined below:<br>  max\_delivery\_attempts - (Required) Specifies the maximum number of delivery retry attempts for events.<br>  event\_time\_to\_live - (Required) Specifies the time to live (in minutes) for events. Supported range is 1 to 1440. Defaults to 1440. See official documentation for more details. | `any` | `null` | no |
| <a name="input_scope"></a> [scope](#input\_scope) | (Required) Specifies the scope at which the EventGrid Event Subscription should be created. Changing this forces a new resource to be created. | `any` | n/a | yes |
| <a name="input_service_bus_queue_endpoint_id"></a> [service\_bus\_queue\_endpoint\_id](#input\_service\_bus\_queue\_endpoint\_id) | (Optional) Specifies the id where the Service Bus Queue is located. | `any` | `null` | no |
| <a name="input_service_bus_topic_endpoint_id"></a> [service\_bus\_topic\_endpoint\_id](#input\_service\_bus\_topic\_endpoint\_id) | (Optional) Specifies the id where the Service Bus Topic is located. | `any` | `null` | no |
| <a name="input_storage_blob_dead_letter_destination"></a> [storage\_blob\_dead\_letter\_destination](#input\_storage\_blob\_dead\_letter\_destination) | (Optional) A storage\_blob\_dead\_letter\_destination block as defined below.<br>  storage\_account\_id - (Required) Specifies the id of the storage account id where the storage blob is located.<br>  storage\_blob\_container\_name - (Required) Specifies the name of the Storage blob container that is the destination of the deadletter events. | `any` | `null` | no |
| <a name="input_storage_queue_endpoint"></a> [storage\_queue\_endpoint](#input\_storage\_queue\_endpoint) | (Optional) A storage\_queue\_endpoint block as defined below:<br>   storage\_account\_id - (Required) Specifies the id of the storage account id where the storage queue is located.<br>   queue\_name - (Required) Specifies the name of the storage queue where the Event Subscription will receive events.<br>   queue\_message\_time\_to\_live\_in\_seconds - (Optional) Storage queue message time to live in seconds. | `any` | `null` | no |
| <a name="input_subject_filter"></a> [subject\_filter](#input\_subject\_filter) | subject\_filter supports the following:<br>   subject\_begins\_with - (Optional) A string to filter events for an event subscription based on a resource path prefix.<br>   subject\_ends\_with - (Optional) A string to filter events for an event subscription based on a resource path suffix.<br>   case\_sensitive - (Optional) Specifies if subject\_begins\_with and subject\_ends\_with case sensitive. This value defaults to false. | `any` | `null` | no |
| <a name="input_webhook_endpoint"></a> [webhook\_endpoint](#input\_webhook\_endpoint) | (Optional) A webhook\_endpoint block as defined below:<br>   url - (Required) Specifies the url of the webhook where the Event Subscription will receive events.<br>   base\_url - (Computed) The base url of the webhook where the Event Subscription will receive events.<br>   max\_events\_per\_batch - (Optional) Maximum number of events per batch.<br>   preferred\_batch\_size\_in\_kilobytes - (Optional) Preferred batch size in Kilobytes.<br>   active\_directory\_tenant\_id - (Optional) The Azure Active Directory Tenant ID to get the access token that will be included as the bearer token in delivery requests.<br>   active\_directory\_app\_id\_or\_uri - (Optional) The Azure Active Directory Application ID or URI to get the access token that will be included as the bearer token in delivery requests. | `any` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_id"></a> [id](#output\_id) | The ID of the EventGrid Event Subscription. |
