variable "global_settings" {
  description = "Global settings object (see module README.md)"
  default     = null
}

variable "client_config" {
  description = "Client configuration object (see module README.md)."
  default     = null
}

variable "combined_objects" {
  default = null
}

variable "name" {
  description = "(Required) Specifies the name of the EventGrid Event Subscription resource. Changing this forces a new resource to be created."

}

variable "scope" {
  description = "(Required) Specifies the scope at which the EventGrid Event Subscription should be created. Changing this forces a new resource to be created."
}

variable "expiration_time_utc" {
  description = "(Optional) Specifies the expiration time of the event subscription (Datetime Format RFC 3339)."
  default     = null
}

variable "event_delivery_schema" {
  description = "(Optional) Specifies the schema in which incoming events will be published to this domain. Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema"
  type        = string
  default     = "EventGridSchema"

  validation {
    condition     = contains(["CloudEventSchemaV1_0", "CustomEventSchema", "EventGridSchema"], var.event_delivery_schema)
    error_message = "Allowed values are CloudEventSchemaV1_0, CustomEventSchema, or EventGridSchema."
  }
}

variable "azure_function_endpoint" {
  description = <<EOT
  An azure_function_endpoint supports the following:
  function_id - (Required) Specifies the ID of the Function where the Event Subscription will receive events. This must be the functions ID in format {function_app.id}/functions/{name}.
  max_events_per_batch - (Optional) Maximum number of events per batch.
  preferred_batch_size_in_kilobytes - (Optional) Preferred batch size in Kilobytes.
  EOT
  default     = null
}

variable "eventhub_endpoint_id" {
  description = "(Optional) Specifies the id where the Event Hub is located."
  default     = null
}

variable "hybrid_connection_endpoint_id" {
  description = "(Optional) Specifies the id where the Hybrid Connection is located."
  default     = null

}

variable "service_bus_queue_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Queue is located."
  default     = null
}

variable "service_bus_topic_endpoint_id" {
  description = "(Optional) Specifies the id where the Service Bus Topic is located."
  default     = null
}

variable "storage_queue_endpoint" {
  description = <<EOT
   (Optional) A storage_queue_endpoint block as defined below:
   storage_account_id - (Required) Specifies the id of the storage account id where the storage queue is located.
   queue_name - (Required) Specifies the name of the storage queue where the Event Subscription will receive events.
   queue_message_time_to_live_in_seconds - (Optional) Storage queue message time to live in seconds.
   EOT
  default     = null
}

variable "webhook_endpoint" {
  description = <<EOT
   (Optional) A webhook_endpoint block as defined below:
   url - (Required) Specifies the url of the webhook where the Event Subscription will receive events.
   base_url - (Computed) The base url of the webhook where the Event Subscription will receive events.
   max_events_per_batch - (Optional) Maximum number of events per batch.
   preferred_batch_size_in_kilobytes - (Optional) Preferred batch size in Kilobytes.
   active_directory_tenant_id - (Optional) The Azure Active Directory Tenant ID to get the access token that will be included as the bearer token in delivery requests.
   active_directory_app_id_or_uri - (Optional) The Azure Active Directory Application ID or URI to get the access token that will be included as the bearer token in delivery requests.
   EOT
  default     = null
}




variable "included_event_types" {
  description = "(Optional) A list of applicable event types that need to be part of the event subscription."
  default     = null
}

variable "subject_filter" {
  description = <<EOT
   subject_filter supports the following:
   subject_begins_with - (Optional) A string to filter events for an event subscription based on a resource path prefix.
   subject_ends_with - (Optional) A string to filter events for an event subscription based on a resource path suffix.
   case_sensitive - (Optional) Specifies if subject_begins_with and subject_ends_with case sensitive. This value defaults to false.
   EOT

  default = null
}

variable "advanced_filter" {
  description = <<EOT
  (Optional) A advanced_filter block as defined below
   A advanced_filter supports the following nested blocks:
   bool_equals - Compares a value of an event using a single boolean value.
   number_greater_than - Compares a value of an event using a single floating point number.
   number_greater_than_or_equals - Compares a value of an event using a single floating point number.
   number_less_than - Compares a value of an event using a single floating point number.
   number_less_than_or_equals - Compares a value of an event using a single floating point number.
   number_in - Compares a value of an event using multiple floating point numbers.
   number_not_in - Compares a value of an event using multiple floating point numbers.
   number_in_range - Compares a value of an event using multiple floating point number ranges.
   number_not_in_range - Compares a value of an event using multiple floating point number ranges.
   string_begins_with - Compares a value of an event using multiple string values.
   string_not_begins_with - Compares a value of an event using multiple string values.
   string_ends_with - Compares a value of an event using multiple string values.
   string_not_ends_with - Compares a value of an event using multiple string values.
   string_contains - Compares a value of an event using multiple string values.
   string_not_contains - Compares a value of an event using multiple string values.
   string_in - Compares a value of an event using multiple string values.
   string_not_in - Compares a value of an event using multiple string values.
   is_not_null - Evaluates if a value of an event isn't NULL or undefined.
   is_null_or_undefined - Evaluates if a value of an event is NULL or undefined.
   EOT
  default     = null
}

variable "delivery_identity" {
  description = <<EOT
  (Optional) A delivery_identity block as defined below:
  type - (Required) Specifies the type of Managed Service Identity that is used for event delivery. Allowed value is SystemAssigned, UserAssigned.
  user_assigned_identity - (Optional) The user identity associated with the resource.
  EOT
  default     = null
}

variable "delivery_property" {
  description = <<EOT
  (Optional) A delivery_property block as defined below:
  header_name - (Required) The name of the header to send on to the destination
  type - (Required) Either Static or Dynamic
  value - (Optional) If the type is Static, then provide the value to use
  source_field - (Optional) If the type is Dynamic, then provide the payload field to be used as the value. Valid source fields differ by subscription type.
  secret - (Optional) True if the value is a secret and should be protected, otherwise false. If True, then this value won't be returned from Azure API calls
  EOT
  default     = null
}


variable "dead_letter_identity" {
  description = <<EOT
  storage_blob_dead_letter_destination must be specified when a dead_letter_identity is specified
  (Optional) A dead_letter_identity block as defined below:
  type - (Required) Specifies the type of Managed Service Identity that is used for dead lettering. Allowed value is SystemAssigned, UserAssigned.
  user_assigned_identity - (Optional) The user identity associated with the resource
  EOT
  default     = null
}

variable "storage_blob_dead_letter_destination" {
  description = <<EOT
  (Optional) A storage_blob_dead_letter_destination block as defined below.
  storage_account_id - (Required) Specifies the id of the storage account id where the storage blob is located.
  storage_blob_container_name - (Required) Specifies the name of the Storage blob container that is the destination of the deadletter events.
  EOT
  default     = null
}

variable "retry_policy" {
  description = <<EOT
  (Optional) A retry_policy block as defined below:
  max_delivery_attempts - (Required) Specifies the maximum number of delivery retry attempts for events.
  event_time_to_live - (Required) Specifies the time to live (in minutes) for events. Supported range is 1 to 1440. Defaults to 1440. See official documentation for more details.
  EOT
  default     = null
}

variable "labels" {
  description = "(Optional) A list of labels to assign to the event subscription."
  default     = null
}


variable "advanced_filtering_on_arrays_enabled" {
  description = "(Optional) Specifies whether advanced filters should be evaluated against an array of values instead of expecting a singular value. Defaults to false."
  default     = null
}

variable "remote_objects" {
  default = null
}





