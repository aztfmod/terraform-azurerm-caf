
resource "azurecaf_name" "netprofile" {
  name          = var.settings.name
  resource_type = "azurerm_network_profile"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_network_profile" "netprofile" {
  name                = azurecaf_name.netprofile.result
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = local.tags

  dynamic "container_network_interface" {
    for_each = try(var.settings, null) == null ? [] : [1]

    content {
      name = container_network_interface.value.name
      dynamic "ip_configuration" {
        for_each = try(container_network_interface.value.ip_configurations, {})
        content {
          name      = ip_configuration.value.name
          subnet_id = lookup(container_network_interface.value, "lz_key", null) == null ?  var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id : var.vnets[container_network_interface.value.lz_key][container_network_interface.value.vnet_key].subnets[container_network_interface.value.subnet_key].id
        }
      }
    }
  }
}
