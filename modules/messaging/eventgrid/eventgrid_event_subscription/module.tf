
resource "azurecaf_name" "eges" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_event_subscription"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_eventgrid_event_subscription" "eges" {
  name = azurecaf_name.eges.result
  scope = var.settings.scope
  expiration_time_utc = try(var.settings.expiration_time_utc, null)
  event_delivery_schema = try(var.settings.event_delivery_schema, null)
  dynamic "azure_function_endpoint" {
    for_each = try(var.settings.azure_function_endpoint, null) != null ? [var.settings.azure_function_endpoint] : []
    content {
      function_id = try(azure_function_endpoint.value.function_id, null)
      max_events_per_batch = try(azure_function_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(azure_function_endpoint.value.preferred_batch_size_in_kilobytes, null)
    }
  }
  dynamic "eventhub_endpoint" {
    for_each = try(var.settings.eventhub_endpoint, null) != null ? [var.settings.eventhub_endpoint] : []
    content {
      eventhub_id = try(eventhub_endpoint.value.eventhub_id, null)
    }
  }
  eventhub_endpoint_id = try(var.settings.eventhub_endpoint_id, null)
  dynamic "hybrid_connection_endpoint" {
    for_each = try(var.settings.hybrid_connection_endpoint, null) != null ? [var.settings.hybrid_connection_endpoint] : []
    content {
      hybrid_connection_id = try(hybrid_connection_endpoint.value.hybrid_connection_id, null)
    }
  }
  hybrid_connection_endpoint_id = try(var.settings.hybrid_connection_endpoint_id, null)
  service_bus_queue_endpoint_id = try(var.settings.service_bus_queue_endpoint_id, null)
  service_bus_topic_endpoint_id = try(var.settings.service_bus_topic_endpoint_id, null)
  dynamic "storage_queue_endpoint" {
    for_each = try(var.settings.storage_queue_endpoint, null) != null ? [var.settings.storage_queue_endpoint] : []
    content {
      storage_account_id = try(storage_queue_endpoint.value.storage_account_id, null)
      queue_name = try(storage_queue_endpoint.value.queue_name, null)
      queue_message_time_to_live_in_seconds = try(storage_queue_endpoint.value.queue_message_time_to_live_in_seconds, null)
    }
  }
  dynamic "webhook_endpoint" {
    for_each = try(var.settings.webhook_endpoint, null) != null ? [var.settings.webhook_endpoint] : []
    content {
      url = try(webhook_endpoint.value.url, null)
      base_url = try(webhook_endpoint.value.base_url, null)
      max_events_per_batch = try(webhook_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(webhook_endpoint.value.preferred_batch_size_in_kilobytes, null)
      active_directory_tenant_id = try(webhook_endpoint.value.active_directory_tenant_id, null)
      active_directory_app_id_or_uri = try(webhook_endpoint.value.active_directory_app_id_or_uri, null)
    }
  }
  included_event_types = try(var.settings.included_event_types, null)
  dynamic "subject_filter" {
    for_each = try(var.settings.subject_filter, null) != null ? [var.settings.subject_filter] : []
    content {
      subject_begins_with = try(subject_filter.value.subject_begins_with, null)
      subject_ends_with = try(subject_filter.value.subject_ends_with, null)
      case_sensitive = try(subject_filter.value.case_sensitive, null)
    }
  }
  dynamic "advanced_filter" {
    for_each = try(var.settings.advanced_filter, null) != null ? [var.settings.advanced_filter] : []
    content {
      #bool_equals = try(advanced_filter.value.bool_equals, null)
      #number_greater_than = try(advanced_filter.value.number_greater_than, null)
      #number_greater_than_or_equals = try(advanced_filter.value.number_greater_than_or_equals, null)
      #number_less_than = try(advanced_filter.value.number_less_than, null)
      #number_less_than_or_equals = try(advanced_filter.value.number_less_than_or_equals, null)
      #number_in = try(advanced_filter.value.number_in, null)
      #number_not_in = try(advanced_filter.value.number_not_in, null)
      #number_in_range = try(advanced_filter.value.number_in_range, null)
      #number_not_in_range = try(advanced_filter.value.number_not_in_range, null)
      #string_begins_with = try(advanced_filter.value.string_begins_with, null)
      #string_not_begins_with = try(advanced_filter.value.string_not_begins_with, null)
      #string_ends_with = try(advanced_filter.value.string_ends_with, null)
      #string_not_ends_with = try(advanced_filter.value.string_not_ends_with, null)
      #string_contains = try(advanced_filter.value.string_contains, null)
      #string_not_contains = try(advanced_filter.value.string_not_contains, null)
      #string_in = try(advanced_filter.value.string_in, null)
      #string_not_in = try(advanced_filter.value.string_not_in, null)
      #is_not_null = try(advanced_filter.value.is_not_null, null)
      #is_null_or_undefined = try(advanced_filter.value.is_null_or_undefined, null)
      #key = try(advanced_filter.value.key, null)
      #value = try(advanced_filter.value.value, null)
      #values = try(advanced_filter.value.values, null)
    }
  }
  dynamic "delivery_identity" {
    for_each = try(var.settings.delivery_identity, null) != null ? [var.settings.delivery_identity] : []
    content {
      type = try(delivery_identity.value.type, null)
      user_assigned_identity = try(delivery_identity.value.user_assigned_identity, null)
    }
  }
  dynamic "delivery_property" {
    for_each = try(var.settings.delivery_property, null) != null ? [var.settings.delivery_property] : []
    content {
      header_name = try(delivery_property.value.header_name, null)
      type = try(delivery_property.value.type, null)
      value = try(delivery_property.value.value, null)
      source_field = try(delivery_property.value.source_field, null)
      secret = try(delivery_property.value.secret, null)
    }
  }
  dynamic "dead_letter_identity" {
    for_each = try(var.settings.dead_letter_identity, null) != null ? [var.settings.dead_letter_identity] : []
    content {
      type = try(dead_letter_identity.value.type, null)
      user_assigned_identity = try(dead_letter_identity.value.user_assigned_identity, null)
    }
  }
  dynamic "storage_blob_dead_letter_destination" {
    for_each = try(var.settings.storage_blob_dead_letter_destination, null) != null ? [var.settings.storage_blob_dead_letter_destination] : []
    content {
      storage_account_id = try(storage_blob_dead_letter_destination.value.storage_account_id, null)
      storage_blob_container_name = try(storage_blob_dead_letter_destination.value.storage_blob_container_name, null)
    }
  }
  dynamic "storage_blob_dead_letter_destination" {
    for_each = try(var.settings.storage_blob_dead_letter_destination, null) != null ? [var.settings.storage_blob_dead_letter_destination] : []
    content {
      storage_account_id = try(storage_blob_dead_letter_destination.value.storage_account_id, null)
      storage_blob_container_name = try(storage_blob_dead_letter_destination.value.storage_blob_container_name, null)
    }
  }
  dynamic "retry_policy" {
    for_each = try(var.settings.retry_policy, null) != null ? [var.settings.retry_policy] : []
    content {
      max_delivery_attempts = try(retry_policy.value.max_delivery_attempts, null)
      event_time_to_live = try(retry_policy.value.event_time_to_live, null)
    }
  }
  labels = try(var.settings.labels, null)
  advanced_filtering_on_arrays_enabled = try(var.settings.advanced_filtering_on_arrays_enabled, null)
}