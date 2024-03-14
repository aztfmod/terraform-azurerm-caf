resource "azurerm_vpn_gateway_nat_rule" "vpn_gateway_nat_rule" {
  name                = var.settings.name
  resource_group_name = var.resource_group_name
  vpn_gateway_id      = var.vpn_gateway_id
  ip_configuration_id = try(var.settings.ip_configuration_id, null)

  mode = var.settings.mode
  type = var.settings.type

  dynamic "external_mapping" {
    for_each = try(var.settings.external_mapping, {})

    content {
      address_space = external_mapping.value.address_space
      port_range    = try(external_mapping.value.port_range, null)
    }
  }

  dynamic "internal_mapping" {
    for_each = try(var.settings.internal_mapping, {})

    content {
      address_space = internal_mapping.value.address_space
      port_range    = try(internal_mapping.value.port_range, null)
    }
  }
}
