# Terraform azurerm resource: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/iothub

resource "azurecaf_name" "ioth" {
  name          = var.settings.name
  resource_type = "azurerm_iothub"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_iothub" "iothub" {
  name                        = azurecaf_name.ioth.result
  resource_group_name         = local.resource_group_name
  location                    = local.location
  event_hub_partition_count   = try(var.settings.event_hub_partition_count, null)
  event_hub_retention_in_days = try(var.settings.event_hub_retention_in_days, null)

  sku {
    name     = var.settings.sku.name
    capacity = var.settings.sku.capacity
  }

  dynamic "endpoint" {
    for_each = try(var.settings.endpoints, {})
    content {
      name                       = endpoint.key
      type                       = endpoint.value.type
      resource_group_name        = try(var.remote_objects.resource_groups[try(endpoint.value.resource_group.lz_key, var.client_config.landingzone_key)][endpoint.value.resource_group.key].name, null)
      batch_frequency_in_seconds = try(endpoint.value.batch_frequency_in_seconds, null)
      max_chunk_size_in_bytes    = try(endpoint.value.max_chunk_size_in_bytes, null)
      encoding                   = try(endpoint.value.encoding, null)
      file_name_format           = try(endpoint.value.file_name_format, "{iothub}/{partition}/{YYYY}/{MM}/{DD}/{HH}/{mm}")
      container_name = endpoint.value.type == "AzureIotHub.StorageContainer" ? try(
        var.remote_objects.storage_accounts[try(endpoint.value.storage_account.lz_key, var.client_config.landingzone_key)][endpoint.value.storage_account.key].containers[endpoint.value.storage_account.container_key].name,
        endpoint.value.container_name,
      ) : null
      connection_string = try(endpoint.value.authentication_type, null) == "identityBased" ? null : try(
        var.remote_objects.event_hub_auth_rules[try(endpoint.value.event_hub_auth_rule.lz_key, var.client_config.landingzone_key)][endpoint.value.event_hub_auth_rule.key].primary_connection_string,
        var.remote_objects.storage_accounts[try(endpoint.value.storage_account.lz_key, var.client_config.landingzone_key)][endpoint.value.storage_account.key].primary_blob_connection_string,
        endpoint.value.connection_string,
      )
      authentication_type = try(endpoint.value.authentication_type, null)
      identity_id = try(
        var.remote_objects.managed_identities[try(endpoint.value.identity.lz_key, var.client_config.landingzone_key)][endpoint.value.identity.key].id,
        endpoint.value.identity_id,
        endpoint.value.identity.id,
        null
      )
      endpoint_uri = try(endpoint.value.authentication_type, null) == "identityBased" ? try(
        format("https://%s.servicebus.windows.net:443/", var.remote_objects.event_hub_namespaces[try(endpoint.value.event_hub_namespace.lz_key, var.client_config.landingzone_key)][endpoint.value.event_hub_namespace.key].name),
        var.remote_objects.storage_accounts[try(endpoint.value.storage_account.lz_key, var.client_config.landingzone_key)][endpoint.value.storage_account.key].primary_blob_endpoint,
        endpoint.value.endpoint_uri, null
      ) : null
      entity_path = try(endpoint.value.authentication_type, null) == "identityBased" ? try(
        var.remote_objects.event_hubs[try(endpoint.value.event_hub.lz_key, var.client_config.landingzone_key)][endpoint.value.event_hub.key].name,
        endpoint.value.entity_path,
        null
      ) : null
    }
  }

  dynamic "route" {
    for_each = try(var.settings.routes, {})
    content {
      name           = route.key
      source         = try(route.value.source, null)
      condition      = try(route.value.condition, null)
      endpoint_names = try(route.value.endpoint_names, null)
      enabled        = try(route.value.enabled, null)
    }
  }

  dynamic "enrichment" {
    for_each = try(var.settings.enrichment, null) == null ? [] : [1]
    content {
      key            = var.settings.enrichment.key
      value          = var.settings.enrichment.value
      endpoint_names = var.settings.enrichment.endpoint_names
    }
  }

  dynamic "fallback_route" {
    for_each = try(var.settings.fallback_route, null) == null ? [] : [1]
    content {
      source         = try(var.settings.fallback_route.source, null)
      condition      = try(var.settings.fallback_route.condition, null)
      endpoint_names = try(var.settings.fallback_route.endpoint_names, null)
      enabled        = try(var.settings.fallback_route.enabled, null)
    }
  }

  dynamic "file_upload" {
    for_each = try(var.settings.file_upload, null) == null ? [] : [1]
    content {
      # requires azurerm provider >= 3.0.0
      # authentication_type   = try(var.settings.file_upload.authentication_type, null)
      # identity_id           = try(var.settings.file_upload.identity_id, null)
      connection_string = try(
        var.remote_objects.storage_accounts[try(var.settings.file_upload.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.file_upload.storage_account.key].primary_blob_connection_string,
        var.settings.file_upload.connection_string,
      )
      container_name = try(
        var.remote_objects.storage_accounts[try(var.settings.file_upload.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.file_upload.storage_account.key].containers[var.settings.file_upload.storage_account.container_key].name,
        var.settings.file_upload.container_name
      )
      sas_ttl            = try(var.settings.file_upload.sas_ttl, null)
      notifications      = try(var.settings.file_upload.notifications, null)
      lock_duration      = try(var.settings.file_upload.lock_duration, null)
      default_ttl        = try(var.settings.file_upload.default_ttl, null)
      max_delivery_count = try(var.settings.file_upload.max_delivery_count, null)
    }
  }

  dynamic "identity" {
    for_each = lookup(var.settings, "identity", {}) == {} ? [] : [1]
    content {
      type         = var.settings.identity.type
      identity_ids = local.managed_identities
    }
  }

  dynamic "cloud_to_device" {
    for_each = try(var.settings.cloud_to_device, null) == null ? [] : [1]
    content {
      max_delivery_count = try(var.settings.cloud_to_device.max_delivery_count, null)
      default_ttl        = try(var.settings.cloud_to_device.default_ttl, null)
      dynamic "feedback" {
        for_each = try(var.settings.cloud_to_device.feedback, null) == null ? [] : [1]
        content {
          time_to_live       = try(var.settings.cloud_to_device.feedback.time_to_live, null)
          max_delivery_count = try(var.settings.cloud_to_device.feedback.max_delivery_count, null)
          lock_duration      = try(var.settings.cloud_to_device.feedback.lock_duration, null)
        }
      }
    }
  }

  dynamic "network_rule_set" {
    for_each = try(var.settings.network_rule_set, null) == null ? [] : [1]
    content {
      default_action                     = try(var.settings.network_rule_set.default_action, null)
      apply_to_builtin_eventhub_endpoint = try(var.settings.network_rule_set.apply_to_builtin_eventhub_endpoint, null)
      dynamic "ip_rule" {
        for_each = try(var.settings.network_rule_set.ip_rule, {})
        content {
          name    = ip_rule.value.name
          ip_mask = ip_rule.value.ip_mask
          action  = try(ip_rule.value.action, null)
        }
      }
    }
  }

  tags = merge(local.tags, lookup(var.settings, "tags", {}))
}
