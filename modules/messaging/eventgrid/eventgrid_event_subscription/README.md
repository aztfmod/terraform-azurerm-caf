module "caf" {
  source  = "aztfmod/caf/azurerm"
  version = "5.1.0"
}

# eventgrid_event_subscription

## Inputs
| Name | Description | Type | Required |
|------|-------------|------|:--------:|
|name| Specifies the name of the EventGrid Event Subscription resource. Changing this forces a new resource to be created.||True|
|scope| Specifies the scope at which the EventGrid Event Subscription should be created. Changing this forces a new resource to be created.||True|
|expiration_time_utc| Specifies the expiration time of the event subscription (Datetime Format `RFC 3339`).||False|
|event_delivery_schema| Specifies the event delivery schema for the event subscription. Possible values include: `EventGridSchema`, `CloudEventSchemaV1_0`, `CustomInputSchema`. Defaults to `EventGridSchema`. Changing this forces a new resource to be created.||False|
|azure_function_endpoint| An `azure_function_endpoint` block as defined below.| Block |False|
|eventhub_endpoint| A `eventhub_endpoint` block as defined below.| Block |False|
|eventhub_endpoint_id| Specifies the id where the Event Hub is located.||False|
|hybrid_connection_endpoint| A `hybrid_connection_endpoint` block as defined below.| Block |False|
|hybrid_connection_endpoint_id| Specifies the id where the Hybrid Connection is located.||False|
|service_bus_queue_endpoint_id| Specifies the id where the Service Bus Queue is located.||False|
|service_bus_topic_endpoint_id| Specifies the id where the Service Bus Topic is located.||False|
|storage_queue_endpoint| A `storage_queue_endpoint` block as defined below.| Block |False|
|webhook_endpoint| A `webhook_endpoint` block as defined below.| Block |False|
|included_event_types| A list of applicable event types that need to be part of the event subscription.||False|
|subject_filter| A `subject_filter` block as defined below.| Block |False|
|advanced_filter| A `advanced_filter` block as defined below.| Block |False|
|delivery_identity| A `delivery_identity` block as defined below.| Block |False|
|delivery_property| A `delivery_property` block as defined below.| Block |False|
|dead_letter_identity| A `dead_letter_identity` block as defined below.| Block |False|
|storage_blob_dead_letter_destination| A `storage_blob_dead_letter_destination` block as defined below.| Block |False|
|storage_blob_dead_letter_destination| A `storage_blob_dead_letter_destination` block as defined below.| Block |False|
|retry_policy| A `retry_policy` block as defined below.| Block |False|
|labels| A list of labels to assign to the event subscription.||False|
|advanced_filtering_on_arrays_enabled| Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to `false`.||False|

## Blocks
| Block | Argument | Description | Required |
|-------|----------|-------------|----------|
|azure_function_endpoint|function_id| Specifies the ID of the Function where the Event Subscription will receive events. This must be the functions ID in format {function_app.id}/functions/{name}.|||True|
|azure_function_endpoint|max_events_per_batch| Maximum number of events per batch.|||False|
|azure_function_endpoint|preferred_batch_size_in_kilobytes| Preferred batch size in Kilobytes.|||False|
|eventhub_endpoint|eventhub_id| Specifies the id of the eventhub where the Event Subscription will receive events.|||True|
|hybrid_connection_endpoint|hybrid_connection_id| Specifies the id of the hybrid connection where the Event Subscription will receive events.|||True|
|storage_queue_endpoint|storage_account_id| Specifies the id of the storage account id where the storage queue is located.|||True|
|storage_queue_endpoint|queue_name| Specifies the name of the storage queue where the Event Subscription will receive events.|||True|
|storage_queue_endpoint|queue_message_time_to_live_in_seconds| Storage queue message time to live in seconds.|||False|
|webhook_endpoint|url| Specifies the url of the webhook where the Event Subscription will receive events.|||True|
|webhook_endpoint|base_url| The base url of the webhook where the Event Subscription will receive events.|||False|
|webhook_endpoint|max_events_per_batch| Maximum number of events per batch.|||False|
|webhook_endpoint|preferred_batch_size_in_kilobytes| Preferred batch size in Kilobytes.|||False|
|webhook_endpoint|active_directory_tenant_id| The Azure Active Directory Tenant ID to get the access token that will be included as the bearer token in delivery requests.|||False|
|webhook_endpoint|active_directory_app_id_or_uri| The Azure Active Directory Application ID or URI to get the access token that will be included as the bearer token in delivery requests.|||False|
|subject_filter|subject_begins_with| A string to filter events for an event subscription based on a resource path prefix.|||False|
|subject_filter|subject_ends_with| A string to filter events for an event subscription based on a resource path suffix.|||False|
|subject_filter|case_sensitive| Specifies if `subject_begins_with` and `subject_ends_with` case sensitive. This value defaults to `false`.|||False|
|advanced_filter|bool_equals|Compares a value of an event using a single boolean value.|||False|
|advanced_filter|number_greater_than|Compares a value of an event using a single floating point number.|||False|
|advanced_filter|number_greater_than_or_equals|Compares a value of an event using a single floating point number.|||False|
|advanced_filter|number_less_than|Compares a value of an event using a single floating point number.|||False|
|advanced_filter|number_less_than_or_equals|Compares a value of an event using a single floating point number.|||False|
|advanced_filter|number_in|Compares a value of an event using multiple floating point numbers.|||False|
|advanced_filter|number_not_in|Compares a value of an event using multiple floating point numbers.|||False|
|advanced_filter|number_in_range|Compares a value of an event using multiple floating point number ranges.|||False|
|advanced_filter|number_not_in_range|Compares a value of an event using multiple floating point number ranges.|||False|
|advanced_filter|string_begins_with|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_not_begins_with|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_ends_with|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_not_ends_with|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_contains|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_not_contains|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_in|Compares a value of an event using multiple string values.|||False|
|advanced_filter|string_not_in|Compares a value of an event using multiple string values.|||False|
|advanced_filter|is_not_null|Evaluates if a value of an event isn't NULL or undefined.|||False|
|advanced_filter|is_null_or_undefined|Evaluates if a value of an event is NULL or undefined.|||False|
|advanced_filter|key| Specifies the field within the event data that you want to use for filtering. Type of the field can be a number, boolean, or string.|||True|
|advanced_filter|value| Specifies a single value to compare to when using a single value operator.|||True|
|advanced_filter|values| Specifies an array of values to compare to when using a multiple values operator.|||True|
|delivery_identity|type| Specifies the type of Managed Service Identity that is used for event delivery. Allowed value is `SystemAssigned`, `UserAssigned`.|||True|
|delivery_identity|user_assigned_identity| The user identity associated with the resource.|||False|
|delivery_property|header_name| The name of the header to send on to the destination|||True|
|delivery_property|type| Either `Static` or `Dynamic`|||True|
|delivery_property|value| If the `type` is `Static`, then provide the value to use|||False|
|delivery_property|source_field| If the `type` is `Dynamic`, then provide the payload field to be used as the value. Valid source fields differ by subscription type.|||False|
|delivery_property|secret| True if the `value` is a secret and should be protected, otherwise false. If True, then this value won't be returned from Azure API calls |||False|
|dead_letter_identity|type| Specifies the type of Managed Service Identity that is used for dead lettering. Allowed value is `SystemAssigned`, `UserAssigned`.|||True|
|dead_letter_identity|user_assigned_identity| The user identity associated with the resource.|||False|
|storage_blob_dead_letter_destination|storage_account_id| Specifies the id of the storage account id where the storage blob is located.|||True|
|storage_blob_dead_letter_destination|storage_blob_container_name| Specifies the name of the Storage blob container that is the destination of the deadletter events.|||True|
|storage_blob_dead_letter_destination|storage_account_id| Specifies the id of the storage account id where the storage blob is located.|||True|
|storage_blob_dead_letter_destination|storage_blob_container_name| Specifies the name of the Storage blob container that is the destination of the deadletter events.|||True|
|retry_policy|max_delivery_attempts| Specifies the maximum number of delivery retry attempts for events.|||True|
|retry_policy|event_time_to_live| Specifies the time to live (in minutes) for events. Supported range is `1` to `1440`. Defaults to `1440`. See [official documentation](https://docs.microsoft.com/en-us/azure/event-grid/manage-event-delivery#set-retry-policy) for more details.|||True|

## Outputs
| Name | Description |
|------|-------------|
|id|The ID of the EventGrid Event Subscription.|||
|topic_name| Specifies the name of the topic to associate with the event subscription.|||
