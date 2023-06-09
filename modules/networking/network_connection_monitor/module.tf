resource "azurerm_network_connection_monitor" "connection_monitor" {
  name                          = var.name // caf_name requires: https://github.com/aztfmod/terraform-provider-azurecaf/issues/241
  notes                         = var.settings.notes
  network_watcher_id            = var.network_watcher_id != null ? var.network_watcher_id : data.azurerm_network_watcher.watcher.id
  location                      = data.azurerm_network_watcher.watcher.location
  output_workspace_resource_ids = local.workspace_ids
  tags                          = local.tags

  dynamic "endpoint" {
    for_each = var.settings.endpoints
    content {
      name                  = endpoint.value.name
      address               = try(endpoint.value.address, null)
      coverage_level        = try(endpoint.value.coverage_level, null)
      excluded_ip_addresses = try(endpoint.value.excluded_ip_addresses, null)
      included_ip_addresses = try(endpoint.value.included_ip_addresses, null)
      target_resource_id = try(
        try(endpoint.target_resource_id,
          var.endpoint_objects[endpoint.value.target_resource_key_caf_type][try(endpoint.value.target_resource_lz_key, var.client_config.landingzone_key)][endpoint.value.target_resource_key].id,
      null))
      target_resource_type = try(endpoint.value.target_resource_type, null)
    }
  }

  dynamic "test_configuration" {
    for_each = { for k, v in var.settings.test_configurations : k => v if v.protocol == "Icmp" }
    content {
      name                      = test_configuration.value.name
      protocol                  = try(test_configuration.value.protocol, null)
      test_frequency_in_seconds = try(test_configuration.value.test_frequency_in_seconds, null)

      icmp_configuration {
        trace_route_enabled = test_configuration.value.icmp_configuration.trace_route_enabled
      }
      dynamic "success_threshold" {
        for_each = try(test_configuration.value.success_threshold, null) != null ? { "yes" = true } : {}
        content {
          checks_failed_percent = try(test_configuration.value.success_threshold.checks_failed_percent, null)
          round_trip_time_ms    = try(test_configuration.value.success_threshold.round_trip_time_ms, null)
        }
      }
    }

  }

  dynamic "test_configuration" {
    for_each = { for k, v in var.settings.test_configurations : k => v if v.protocol == "Tcp" }
    content {
      name                      = test_configuration.value.name
      protocol                  = try(test_configuration.value.protocol, null)
      test_frequency_in_seconds = try(test_configuration.value.test_frequency_in_seconds, null)

      tcp_configuration {
        port                      = test_configuration.value.tcp_configuration.port
        trace_route_enabled       = try(test_configuration.value.tcp_configuration.trace_route_enabled, null)
        destination_port_behavior = try(test_configuration.value.tcp_configuration.destination_port_behavior, null)
      }
      dynamic "success_threshold" {
        for_each = try(test_configuration.value.success_threshold, null) != null ? { "yes" = true } : {}
        content {
          checks_failed_percent = try(test_configuration.value.success_threshold.checks_failed_percent, null)
          round_trip_time_ms    = try(test_configuration.value.success_threshold.round_trip_time_ms, null)
        }
      }
    }
  }
  dynamic "test_configuration" {
    for_each = { for k, v in var.settings.test_configurations : k => v if v.protocol == "Http" }
    content {
      name                      = test_configuration.value.name
      protocol                  = try(test_configuration.value.protocol, null)
      test_frequency_in_seconds = try(test_configuration.value.test_frequency_in_seconds, null)

      http_configuration {
        method                   = try(test_configuration.value.http_configuration.method, null)
        port                     = try(test_configuration.value.http_configuration.port, null)
        path                     = try(test_configuration.value.http_configuration.path, null)
        prefer_https             = try(test_configuration.value.http_configuration.prefer_https, null)
        valid_status_code_ranges = try(test_configuration.value.http_configuration.valid_status_code_ranges, null)
        dynamic "request_header" {
          for_each = test_configuration.value.http_configuration.request_headers
          content {
            name  = request_header.value.header_name
            value = request_header.value.header_value
          }
        }
      }
      dynamic "success_threshold" {
        for_each = try(test_configuration.value.success_threshold, null) != null ? { "yes" = true } : {}
        content {
          checks_failed_percent = try(test_configuration.value.success_threshold.checks_failed_percent, null)
          round_trip_time_ms    = try(test_configuration.value.success_threshold.round_trip_time_ms, null)
        }
      }
    }
  }

  dynamic "test_group" {
    for_each = var.settings.test_groups
    content {

      name                     = test_group.value.name
      destination_endpoints    = test_group.value.destination_endpoint_names
      source_endpoints         = test_group.value.source_endpoint_names
      test_configuration_names = test_group.value.test_configuration_names
      enabled                  = try(test_group.value.enabled, null)
    }
  }
}



// Guess network watcher_name if no info is supplied
// NetworkWatcherRG
// NetworkWatcher_germanywestcentral
data "azurerm_network_watcher" "watcher" {
  name                = var.network_watcher_name != null ? var.network_watcher_name : format("NetworkWatcher_%s", var.location)
  resource_group_name = var.network_watcher_resource_group_name != null ? var.network_watcher_resource_group_name : "NetworkWatcherRG"
}




locals {
  workspace_ids_from_keys = { for key, value in var.settings.output_workspaces :
    key => var.combined_objects_log_analytics[try(value.lz_key, var.client_config.landingzone_key)][value.key].id
    if try(value.key, null) != null
  }
  workspace_from_ids = { for key, value in var.settings.output_workspaces :
    key => value.id
    if try(value.id, null) != null
  }
  workspace_ids       = concat(values(local.workspace_ids_from_keys), values(local.workspace_from_ids))
  name                = var.network_watcher_name != null ? var.network_watcher_name : format("NetworkWatcher_%s", var.location)
  resource_group_name = var.network_watcher_resource_group_name != null ? var.network_watcher_resource_group_name : "NetworkWatcherRG"


}

