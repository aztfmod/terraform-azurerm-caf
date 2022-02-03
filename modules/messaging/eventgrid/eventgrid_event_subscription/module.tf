# naming convention
resource "azurecaf_name" "egs" {
  name          = var.name
  resource_type = "azurerm_eventgrid_event_subscription"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

#https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventgrid_event_subscription
resource "azurerm_eventgrid_event_subscription" "egs" {
  name                  = azurecaf_name.egs.result
  scope                 = var.scope
  expiration_time_utc   = var.expiration_time_utc
  event_delivery_schema = var.event_delivery_schema


  dynamic "azure_function_endpoint" {
    for_each = try(var.azure_function_endpoint, null) == null ? [] : [1]

    content {
      function_id          = azure_function_endpoint.value.function_id
      max_events_per_batch = try(azure_function_endpoint.value.max_events_per_batch, null)
    }
  }
  eventhub_endpoint_id          = try(var.eventhub_endpoint_id, null)
  hybrid_connection_endpoint_id = try(var.hybrid_connection_endpoint_id, null)
  service_bus_queue_endpoint_id = try(var.service_bus_queue_endpoint_id, null)
  service_bus_topic_endpoint_id = try(var.service_bus_topic_endpoint_id, null)

  dynamic "storage_queue_endpoint" {
    for_each = try(var.azure_function_endpoint, null) == null ? [] : [1]

    content {
      #storage_account_id                    = storage_queue_endpoint.value.storage_account_id
      storage_account_id = coalesce(
        try(local.combined_objects_storage_accounts[each.value.storage_account.lz_key][storage_queue_endpoint.value.storage_account_key].id, null),
        try(local.combined_objects_storage_accounts[local.client_config.landingzone_key][storage_queue_endpoint.value.storage_account_key].id, null),
        try(module.storage_accounts[storage_queue_endpoint.value.storage_account_key].id, null),
        try(storage_queue_endpoint.value.storage_account_id, null)
      )
      queue_name                            = storage_queue_endpoint.value.queue_name
      queue_message_time_to_live_in_seconds = try(storage_queue_endpoint.value.queue_message_time_to_live_in_seconds, null)
    }
  }

  dynamic "webhook_endpoint" {
    for_each = try(var.webhook_endpoint, null) == null ? [] : [1]

    content {
      url                               = webhook_endpoint.value.url
      base_url                          = webhook_endpoint.value.base_url
      max_events_per_batch              = try(webhook_endpoint.value.max_events_per_batch, null)
      preferred_batch_size_in_kilobytes = try(webhook_endpoint.value.preferred_batch_size_in_kilobytes, null)
      active_directory_tenant_id        = try(webhook_endpoint.value.active_directory_tenant_id, null)
      active_directory_app_id_or_uri    = try(webhook_endpoint.value.active_directory_app_id_or_uri, null)
    }
  }

  included_event_types = try(var.included_event_types, [])


  dynamic "subject_filter" {
    for_each = try(var.subject_filter, null) == null ? [] : [1]

    content {
      subject_begins_with = try(var.subject_begins_with, null)
      subject_ends_with   = try(var.subject_ends_with, null)
      case_sensitive      = try(var.subject_filter, null)
    }
  }

  dynamic "advanced_filter" {
    for_each = try(var.advanced_filter, null) == null ? [] : [1]

    content {
      dynamic "bool_equals" {
        for_each = try(var.advanced_filter.bool_equals, [])
        content {
          key   = bool_equals.value.key
          value = bool_equals.value.value
        }
      }
      dynamic "number_greater_than" {
        for_each = try(var.advanced_filter.number_greater_than, [])
        content {
          key   = number_greater_than.value.key
          value = number_greater_than.value.value
        }
      }
      dynamic "number_greater_than_or_equals" {
        for_each = try(var.advanced_filter.number_greater_than_or_equals, [])
        content {
          key   = number_greater_than_or_equals.value.key
          value = number_greater_than_or_equals.value.value
        }
      }
      dynamic "number_less_than" {
        for_each = try(var.advanced_filter.number_less_than, [])
        content {
          key   = number_less_than.value.key
          value = number_less_than.value.value
        }
      }
      dynamic "number_less_than_or_equals" {
        for_each = try(var.advanced_filter.number_less_than_or_equals, [])
        content {
          key   = number_less_than_or_equals.value.key
          value = number_less_than_or_equals.value.value
        }
      }
      dynamic "number_in" {
        for_each = try(var.advanced_filter.number_in, [])
        content {
          key    = number_in.value.key
          values = number_in.value.values
        }
      }
      dynamic "number_not_in" {
        for_each = try(var.advanced_filter.number_not_in, [])
        content {
          key    = number_not_in.value.key
          values = number_not_in.value.values
        }
      }
      dynamic "number_in_range" {
        for_each = try(var.advanced_filter.number_in_range, [])
        content {
          key    = number_in_range.value.key
          values = number_in_range.value.values
        }
      }
      dynamic "number_not_in_range" {
        for_each = try(var.advanced_filter.number_not_in_range, [])
        content {
          key    = number_not_in_range.value.key
          values = number_not_in_range.value.values
        }
      }
      dynamic "string_begins_with" {
        for_each = try(var.advanced_filter.string_begins_with, [])
        content {
          key    = string_begins_with.value.key
          values = string_begins_with.value.values
        }
      }
      dynamic "string_not_begins_with" {
        for_each = try(var.advanced_filter.string_not_begins_with, [])
        content {
          key    = string_not_begins_with.value.key
          values = string_not_begins_with.value.values
        }
      }
      dynamic "string_ends_with" {
        for_each = try(var.advanced_filter.string_ends_with, [])
        content {
          key    = string_ends_with.value.key
          values = string_ends_with.value.values
        }
      }
      dynamic "string_not_ends_with" {
        for_each = try(var.advanced_filter.string_not_ends_with, [])
        content {
          key    = string_not_ends_with.value.key
          values = string_not_ends_with.value.values
        }
      }
      dynamic "string_contains" {
        for_each = try(var.advanced_filter.string_contains, [])
        content {
          key    = string_contains.value.key
          values = string_contains.value.values
        }
      }
      dynamic "string_not_contains" {
        for_each = try(var.advanced_filter.string_not_contains, [])
        content {
          key    = string_not_contains.value.key
          values = string_not_contains.value.values
        }
      }
      dynamic "string_in" {
        for_each = try(var.advanced_filter.string_in, [])
        content {
          key    = string_in.value.key
          values = string_in.value.values
        }
      }
      dynamic "string_not_in" {
        for_each = try(var.advanced_filter.string_in, [])
        content {
          key    = string_not_in.value.key
          values = string_not_in.value.values
        }
      }
      dynamic "is_not_null" {
        for_each = try(var.advanced_filter.is_not_null, [])
        content {
          key = is_not_null.value.key
        }
      }


    }
  }

  dynamic "delivery_identity" {
    for_each = try(var.delivery_identity, null) == null ? [] : [1]

    content {
      type                   = var.delivery_identity.type
      user_assigned_identity = lower(var.delivery_identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  dynamic "delivery_property" {
    for_each = try(var.delivery_property, null) == null ? [] : [1]

    content {
      header_name  = var.delivery_property.header_name
      type         = var.delivery_property.type
      value        = lower(var.delivery_property.type) == "static" ? var.delivery_property.value : null
      source_field = lower(var.delivery_property.type) == "dynamic" ? var.delivery_property.source_field : null
      secret       = try(var.delivery_property.secret, null)

    }
  }

  dynamic "dead_letter_identity" {
    for_each = try(var.dead_letter_identity, null) == null ? [] : [1]

    content {
      type                   = var.dead_letter_identity.type
      user_assigned_identity = lower(var.dead_letter_identity.type) == "userassigned" ? local.managed_identities : null
    }
  }

  dynamic "storage_blob_dead_letter_destination" {
    for_each = try(var.storage_blob_dead_letter_destination, null) == null ? [] : [1]

    content {
      storage_account_id          = var.storage_blob_dead_letter_destination.storage_account_id
      storage_blob_container_name = var.storage_blob_dead_letter_destination.storage_blob_container_name
    }
  }

  dynamic "retry_policy" {
    for_each = try(var.retry_policy, null) == null ? [] : [1]

    content {
      max_delivery_attempts = var.retry_policy.max_delivery_attempts
      event_time_to_live    = try(var.retry_policy.event_time_to_live, 1440)
    }
  }

  labels                               = try(var.labels, [])
  advanced_filtering_on_arrays_enabled = try(var.advanced_filtering_on_arrays_enabled, false)









}