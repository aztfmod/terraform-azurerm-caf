resource "azurerm_traffic_manager_nested_endpoint" "nested_endpoint" {
  name                                  = var.settings.name
  target_resource_id                    = var.target_resource_id
  priority                              = try(var.settings.priority, null)
  profile_id                            = var.profile_id
  minimum_child_endpoints               = try(var.settings.minimum_child_endpoints, null)
  weight                                = try(var.settings.weight, null)
  enabled                               = try(var.settings.enabled, null)
  geo_mappings                          = try(var.settings.geo_mappings, null)
  minimum_required_child_endpoints_ipv4 = try(var.settings.minimum_required_child_endpoints_ipv4, null)
  minimum_required_child_endpoints_ipv6 = try(var.settings.minimum_required_child_endpoints_ipv6, null)

  dynamic "custom_header" {
    for_each = try(var.settings.custom_header, null) == null ? [] : [var.settings.custom_header]

    content {
      name  = try(var.settings.custom_header.name, null)
      value = try(var.settings.custom_header.value, null)
    }
  }
  dynamic "subnet" {
    for_each = try(var.settings.subnet, null) == null ? [] : [var.settings.subnet]

    content {
      first = try(var.settings.subnet.first, null)
      last  = try(var.settings.subnet.last, null)
      scope = try(var.settings.subnet.scope, null)
    }
  }
}  