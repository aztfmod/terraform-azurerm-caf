resource "azurerm_traffic_manager_profile" "traffic_manager_profile" {
  name                   = var.settings.name
  resource_group_name    = var.resource_group_name
  traffic_routing_method = var.settings.traffic_routing_method
  tags                   = merge(var.base_tags, try(var.settings.tags, {}))
  profile_status         = try(var.settings.profile_status, null)
  traffic_view_enabled   = try(var.settings.traffic_view_enabled, null)
  max_return             = try(var.settings.max_return, null)

  dynamic "dns_config" {
    for_each = try(var.settings.dns_config, null) == null ? [] : [var.settings.dns_config]

    content {
      relative_name = var.settings.dns_config.relative_name
      ttl           = try(var.settings.dns_config.ttl, null)
    }
  }

  dynamic "monitor_config" {
    for_each = try(var.settings.monitor_config, null) == null ? [] : [var.settings.monitor_config]

    content {
      protocol                     = try(var.settings.monitor_config.protocol, null)
      port                         = try(var.settings.monitor_config.port, null)
      path                         = try(var.settings.monitor_config.path, null)
      interval_in_seconds          = try(var.settings.monitor_config.interval_in_seconds, null)
      timeout_in_seconds           = try(var.settings.monitor_config.timeout_in_seconds, null)
      tolerated_number_of_failures = try(var.settings.monitor_config.tolerated_number_of_failures, null)
      expected_status_code_ranges  = try(var.settings.monitor_config.expected_status_code_ranges, null)

      dynamic "custom_header" {
        for_each = try(var.settings.monitor_config.custom_header, null) == null ? [] : [var.settings.monitor_config.custom_header]

        content {
          name  = try(var.settings.monitor_config.custom_header.name, null)
          value = try(var.settings.monitor_config.custom_header.value, null)
        }
      }
    }
  }


}