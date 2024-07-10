resource "azurerm_maintenance_assignment_dynamic_scope" "maintenance_assignment_dynamic_scope" {
  name                         = var.name
  maintenance_configuration_id = var.maintenance_configuration_id

  filter {
    locations       = try(var.settings.filter.locations, [])
    os_types        = try(var.settings.filter.os_types, [])
    resource_groups = try(var.resource_group_name, [])
    resource_types  = try(var.settings.filter.resource_types, [])
    tag_filter      = try(var.settings.filter.tag_filter, null)

    dynamic "tags" {
      for_each = {
        for key, value in try(var.settings.filter.tags, {}) : key => value
      }

      content {
        tag    = tags.value.tag
        values = tags.value.values
      }
    }
  }
}
