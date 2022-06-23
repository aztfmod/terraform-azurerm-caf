resource "azurerm_traffic_manager_external_endpoint" "external_endpoint" {
  name              = var.settings.name
  profile_id        = var.profile_id
  weight            = var.settings.weight
  target            = var.settings.target
  enabled           = try(var.settings.enabled, null)
  endpoint_location = try(var.settings.endpoint_location, null)
  priority          = try(var.settings.priority, null)
  geo_mappings      = try(var.settings.geo_mappings, null)

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
  