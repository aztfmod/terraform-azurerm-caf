
resource "azurecaf_name" "egstes" {
  name          = var.settings.name
  resource_type = "azurerm_eventgrid_event_subscription"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}
resource "azurerm_eventgrid_system_topic_event_subscription" "egstes" {
  name                  = azurecaf_name.egstes.result
  system_topic          = coalesce(try(var.settings.scope.id, null), try(var.remote_objects.eventgrid_system_topics[try(var.settings.scope.lz_key, var.client_config.landingzone_key)][var.settings.scope.key].name, null))
  resource_group_name   = coalesce(try(var.settings.resource_group.name, null), try(var.remote_objects.all.resource_groups[try(var.settings.resource_group.lz_key, var.client_config.landingzone_key)][var.settings.resource_group.key].name, null), try(var.remote_objects.eventgrid_system_topics[try(var.settings.scope.lz_key, var.client_config.landingzone_key)][var.settings.scope.key].resource_group_name, null))
  expiration_time_utc   = try(var.settings.expiration_time_utc, null)
  event_delivery_schema = try(var.settings.event_delivery_schema, null)
  dynamic "azure_function_endpoint" {
    for_each = try(var.settings.azure_function_endpoint, null) != null ? [var.settings.azure_function_endpoint] : []
    content {
      function_id                       = can(azure_function_endpoint.value.function.id) ? azure_function_endpoint.value.function.id : can(var.remote_objects.functions[try(azure_function_endpoint.value.function.lz_key, var.client_config.landingzone_key)][azure_function_endpoint.value.function.key].id) ? var.remote_objects.functions[try(azure_function_endpoint.value.function.lz_key, var.client_config.landingzone_key)][azure_function_endpoint.value.function.key].id : null
      max_events_per_batch              = try(azure_function_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(azure_function_endpoint.value.preferred_batch_size_in_kilobytes, null)
    }
  }

  #eventhub_endpoint - (Optional / Deprecated in favour of eventhub_endpoint_id)
  eventhub_endpoint_id = can(var.settings.eventhub.id) ? var.settings.eventhub.id : can(var.remote_objects.eventhubs[try(var.settings.eventhub.lz_key, var.client_config.landingzone_key)][var.settings.eventhub.key].id) ? var.remote_objects.eventhubs[try(var.settings.eventhub.lz_key, var.client_config.landingzone_key)][var.settings.eventhub.key].id : null
  #hybrid_connection_endpoint - (Optional / Deprecated in favour of hybrid_connection_endpoint_id)
  hybrid_connection_endpoint_id = can(var.settings.hybrid_connection.id) ? var.settings.hybrid_connection.id : can(var.remote_objects.hybrid_connections[try(var.settings.hybrid_connection.lz_key, var.client_config.landingzone_key)][var.settings.hybrid_connection.key].id) ? var.remote_objects.hybrid_connections[try(var.settings.hybrid_connection.lz_key, var.client_config.landingzone_key)][var.settings.hybrid_connection.key].id : null
  service_bus_queue_endpoint_id = can(var.settings.servicebus_queues.id) ? var.settings.servicebus_queues.id : can(var.remote_objects.servicebus_queues[try(var.settings.servicebus_queues.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_queues.key].id) ? var.remote_objects.servicebus_queues[try(var.settings.servicebus_queues.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_queues.key].id : null
  service_bus_topic_endpoint_id = can(var.settings.servicebus_topic.id) ? var.settings.servicebus_topic.id : can(var.remote_objects.servicebus_topic[try(var.settings.servicebus_topic.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_topic.key].id) ? var.remote_objects.servicebus_topic[try(var.settings.servicebus_topic.lz_key, var.client_config.landingzone_key)][var.settings.servicebus_topic.key].id : null

  dynamic "storage_queue_endpoint" {
    for_each = try(var.settings.storage_queue_endpoint, null) != null ? [var.settings.storage_queue_endpoint] : []
    content {
      storage_account_id                    = can(storage_queue_endpoint.value.eue_endpoint.storage_account.id) ? storage_queue_endpoint.value.eue_endpoint.storage_account.id : var.remote_objects.storage_accounts[try(storage_queue_endpoint.value.storage_account.lz_key, var.client_config.landingzone_key)][storage_queue_endpoint.value.storage_account.key].id
      queue_name                            = can(storage_queue_endpoint.value.queue.name) ? storage_queue_endpoint.value.queue.name : var.remote_objects.storage_account_queues[try(storage_queue_endpoint.value.queue.lz_key, var.client_config.landingzone_key)][storage_queue_endpoint.value.queue.key].name
      queue_message_time_to_live_in_seconds = try(storage_queue_endpoint.value.queue_message_time_to_live_in_seconds, null)
    }
  }
  dynamic "webhook_endpoint" {
    for_each = try(var.settings.webhook_endpoint, null) != null ? [var.settings.webhook_endpoint] : []
    content {
      url                               = try(webhook_endpoint.value.url, null)
      base_url                          = try(webhook_endpoint.value.base_url, null)
      max_events_per_batch              = try(webhook_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(webhook_endpoint.value.preferred_batch_size_in_kilobytes, null)
      active_directory_tenant_id        = try(webhook_endpoint.value.active_directory_tenant_id, null)
      active_directory_app_id_or_uri    = try(webhook_endpoint.value.active_directory_app_id_or_uri, null)
    }
  }
  included_event_types = try(var.settings.included_event_types, null)

  dynamic "subject_filter" {
    for_each = try(var.settings.subject_filter, null) != null ? [var.settings.subject_filter] : []
    content {
      subject_begins_with = try(subject_filter.value.subject_begins_with, null)
      subject_ends_with = try(subject_filter.value.subject_ends_with, null)
      case_sensitive = try(subject_filter.value.case_sensitive , null)
    }
  }

  dynamic "advanced_filter" {
    for_each = try(var.settings.advanced_filter, null) != null ? [var.settings.advanced_filter] : []
    content {
      dynamic "bool_equals" {
        for_each = try(advanced_filter.value.bool_equals, null) != null ? [advanced_filter.value.bool_equals] : []
        content {
          key   = try(bool_equals.value.key, null)
          value = try(bool_equals.value.value, null)
        }
      }
      dynamic "number_greater_than" {
        for_each = try(advanced_filter.value.number_greater_than, null) != null ? [advanced_filter.value.number_greater_than] : []
        content {
          key   = try(number_greater_than.value.key, null)
          value = try(number_greater_than.value.value, null)

        }
      }
      dynamic "number_greater_than_or_equals" {
        for_each = try(advanced_filter.value.number_greater_than_or_equals, null) != null ? [advanced_filter.value.number_greater_than_or_equals] : []
        content {
          key   = try(number_greater_than_or_equals.value.key, null)
          value = try(number_greater_than_or_equals.value.value, null)
        }
      }
      dynamic "number_less_than" {
        for_each = try(advanced_filter.value.number_less_than, null) != null ? [advanced_filter.value.number_less_than] : []
        content {
          key   = try(number_less_than.value.key, null)
          value = try(number_less_than.value.value, null)
        }
      }
      dynamic "number_less_than_or_equals" {
        for_each = try(advanced_filter.value.number_less_than_or_equals, null) != null ? [advanced_filter.value.number_less_than_or_equals] : []
        content {
          key   = try(number_less_than.value.key, null)
          value = try(number_less_than.value.value, null)
        }
      }
      dynamic "number_in" {
        for_each = try(advanced_filter.value.number_in, null) != null ? [advanced_filter.value.number_in] : []
        content {
          key    = try(number_in.value.key, null)
          values = try(number_in.value.value, null)
        }
      }
      dynamic "number_not_in" {
        for_each = try(advanced_filter.value.number_not_in, null) != null ? [advanced_filter.value.number_not_in] : []
        content {
          key    = try(number_not_in.value.key, null)
          values = try(number_not_in.value.value, null)
        }
      }
      dynamic "number_in_range" {
        for_each = try(advanced_filter.value.number_in_range, null) != null ? [advanced_filter.value.number_in_range] : []
        content {
          key    = try(number_in_range.value.key, null)
          values = try(number_in_range.value.value, null)
        }
      }
      dynamic "number_not_in_range" {
        for_each = try(advanced_filter.value.number_not_in_range, null) != null ? [advanced_filter.value.number_not_in_range] : []
        content {
          key    = try(number_not_in_range.value.key, null)
          values = try(number_not_in_range.value.value, null)
        }
      }
      dynamic "string_begins_with" {
        for_each = try(advanced_filter.value.string_begins_with, null) != null ? [advanced_filter.value.string_begins_with] : []
        content {
          key    = try(string_begins_with.value.key, null)
          values = try(string_begins_with.value.value, null)
        }
      }
      dynamic "string_not_begins_with" {
        for_each = try(advanced_filter.value.string_not_begins_with, null) != null ? [advanced_filter.value.string_not_begins_with] : []
        content {
          key    = try(string_not_begins_with.value.key, null)
          values = try(string_not_begins_with.value.value, null)
        }
      }
      dynamic "string_ends_with" {
        for_each = try(advanced_filter.value.string_ends_with, null) != null ? [advanced_filter.value.string_ends_with] : []
        content {
          key    = try(string_ends_with.value.key, null)
          values = try(string_ends_with.value.value, null)
        }
      }
      dynamic "string_not_ends_with" {
        for_each = try(advanced_filter.value.string_not_ends_with, null) != null ? [advanced_filter.value.string_not_ends_with] : []
        content {
          key    = try(string_not_ends_with.value.key, null)
          values = try(string_not_ends_with.value.value, null)
        }
      }
      dynamic "string_contains" {
        for_each = try(advanced_filter.value.string_contains, null) != null ? [advanced_filter.value.string_contains] : []
        content {
          key    = try(string_contains.value.key, null)
          values = try(string_contains.value.value, null)
        }
      }
      dynamic "string_not_contains" {
        for_each = try(advanced_filter.value.string_not_contains, null) != null ? [advanced_filter.value.string_not_contains] : []
        content {
          key    = try(string_not_contains.value.key, null)
          values = try(string_not_contains.value.value, null)
        }
      }
      dynamic "string_in" {
        for_each = try(advanced_filter.value.string_in, null) != null ? [advanced_filter.value.string_in] : []
        content {
          key    = try(string_in.value.key, null)
          values = try(string_in.value.value, null)
        }
      }
      dynamic "string_not_in" {
        for_each = try(advanced_filter.value.string_not_in, null) != null ? [advanced_filter.value.string_not_in] : []
        content {
          key    = try(string_not_in.value.key, null)
          values = try(string_not_in.value.value, null)
        }
      }
      dynamic "is_not_null" {
        for_each = try(advanced_filter.value.is_not_null, null) != null ? [advanced_filter.value.is_not_null] : []
        content {
          key = try(is_not_null.value.key, null)
        }
      }
      dynamic "is_null_or_undefined" {
        for_each = try(advanced_filter.value.is_null_or_undefined, null) != null ? [advanced_filter.value.is_null_or_undefined] : []
        content {
          key = try(is_null_or_undefined.value.key, null)
        }
      }
    }
  }
  dynamic "delivery_identity" {
    for_each = try(var.settings.delivery_identity, null) != null ? [var.settings.delivery_identity] : []
    content {
      type                   = try(delivery_identity.value.type, null)
      user_assigned_identity = try(delivery_identity.value.user_assigned_identity, null)
    }
  }
  dynamic "delivery_property" {
    for_each = try(var.settings.delivery_property, null) != null ? [var.settings.delivery_property] : []
    content {
      header_name  = try(delivery_property.value.header_name, null)
      type         = try(delivery_property.value.type, null)
      value        = try(delivery_property.value.value, null)
      source_field = try(delivery_property.value.source_field, null)
      secret       = try(delivery_property.value.secret, null)
    }
  }
  dynamic "dead_letter_identity" {
    for_each = try(var.settings.dead_letter_identity, null) != null ? [var.settings.dead_letter_identity] : []
    content {
      type                   = try(dead_letter_identity.value.type, null)
      user_assigned_identity = try(dead_letter_identity.value.user_assigned_identity, null)
    }
  }
  dynamic "storage_blob_dead_letter_destination" {
    for_each = try(var.settings.storage_blob_dead_letter_destination, null) != null ? [var.settings.storage_blob_dead_letter_destination] : []
    content {
      storage_account_id          = try(storage_blob_dead_letter_destination.value.storage_account_id, null)
      storage_blob_container_name = try(storage_blob_dead_letter_destination.value.storage_blob_container_name, null)
    }
  }
  dynamic "storage_blob_dead_letter_destination" {
    for_each = try(var.settings.storage_blob_dead_letter_destination, null) != null ? [var.settings.storage_blob_dead_letter_destination] : []
    content {
      storage_account_id          = try(storage_blob_dead_letter_destination.value.storage_account_id, null)
      storage_blob_container_name = try(storage_blob_dead_letter_destination.value.storage_blob_container_name, null)
    }
  }
  dynamic "retry_policy" {
    for_each = try(var.settings.retry_policy, null) != null ? [var.settings.retry_policy] : []
    content {
      max_delivery_attempts = try(retry_policy.value.max_delivery_attempts, null)
      event_time_to_live    = try(retry_policy.value.event_time_to_live, null)
    }
  }
  labels                               = try(var.settings.labels, null)
  advanced_filtering_on_arrays_enabled = try(var.settings.advanced_filtering_on_arrays_enabled, null)
}