resource "azurerm_network_profile" "this" {
  name                = var.settings.name
  location            = can(var.settings.location) ? var.settings.location : var.resource_group.location
  resource_group_name = var.resource_group.name

  container_network_interface {
    name = var.settings.container_network_interface.name

    dynamic "ip_configuration" {
      for_each = var.settings.container_network_interface.ip_configurations

      content {
        name = ip_configuration.value.name
        subnet_id = coalesce(
          try(ip_configuration.value.subnet_id, null),
          try(var.remote_objects.networking[ip_configuration.value.lz_key][ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id, null),
          try(var.remote_objects.networking[var.client_config.landingzone_key][ip_configuration.value.vnet_key].subnets[ip_configuration.value.subnet_key].id, null),
          try(var.remote_objects.virtual_networks[ip_configuration.value.lz_key][ip_configuration.value.virtual_subnet_key].id, null),
          try(var.remote_objects.virtual_networks[var.client_config.landingzone_key][ip_configuration.value.virtual_subnet_key].id, null)
        )
      }
    }
  }
}
