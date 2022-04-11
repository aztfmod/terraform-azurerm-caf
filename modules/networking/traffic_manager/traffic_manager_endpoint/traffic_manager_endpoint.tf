resource "azurerm_traffic_manager_endpoint" "endpoint" {

  name                = var.settings.name
  resource_group_name = var.resource_group_name
  profile_name        = var.profile_name
  target              = try(var.settings.target, null)
  type                = var.settings.type
  weight              = try(var.settings.weight, null)
  endpoint_status     = try(var.settings.endpoint_status, "Enabled")
  target_resource_id  = try(var.settings.target_resource_id, null)
  priority            = try(var.settings.priority, null )

    dynamic "custom_header" {
    for_each = try(var.settings.custom_header, null) == null ? [] : [var.settings.custom_header]

    content {
      name    = try(var.settings.custom_header.name, null )
      value   = try(var.settings.custom_header.value, "100")
    }
  }
    dynamic "subnet" {
    for_each = try(var.settings.subnet, null) == null ? [] : [var.settings.subnet]

    content {
      first  = try(var.settings.subnet.first, null )
      last   = try(var.settings.subnet.last,  null )
      scope  = try(var.settings.subnet.scope, null )
    }
  }
}
