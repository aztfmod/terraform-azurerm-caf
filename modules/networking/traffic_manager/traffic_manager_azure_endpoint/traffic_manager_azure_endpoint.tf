resource "azurerm_traffic_manager_azure_endpoint" "azure_endpoint" {
  name         = var.settings.name
  priority     = try(var.settings.priority, null)
  profile_id   = var.profile_id
  weight       = try(var.settings.weight, null)
  enabled      = try(var.settings.enabled, null)
  geo_mappings = try(var.settings.geo_mappings, null)
  target_resource_id = coalesce(
    try(var.remote_objects.public_ip_addresses, null),
    try(var.remote_objects.app_services, null),
    try(var.remote_objects.app_services_slot, null)

  )

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