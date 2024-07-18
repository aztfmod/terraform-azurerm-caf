resource "azurerm_maintenance_assignment_dynamic_scope" "maintenance_assignment_dynamic_scope" {
  name                         = var.name
  maintenance_configuration_id = var.maintenance_configuration_id

  filter {
    locations       = try(var.settings.filter.locations, [])
    os_types        = try(var.settings.filter.os_types, [])
    resource_groups = try(flatten([for rg_key in var.settings.filter.resource_group_key : var.resource_groups[var.client_config.landingzone_key][rg_key].name]), try(flatten([for rg, rg_data in var.settings.filter.resources_groups : [for key in rg_data.key : var.resource_groups[var.client_config.landingzone_key][key].name]]), try(flatten([for rg, rg_data in var.settings.filter.resources_groups : [for key in rg_data.key : var.resource_groups[rg_data.lz_key][key].name]]), [])))
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
