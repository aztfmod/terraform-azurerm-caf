resource "azurecaf_name" "lngw" {
  name          = var.settings.name
  resource_type = "azurerm_local_network_gateway"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_local_network_gateway" "lngw" {
  name                = azurecaf_name.lngw.result
  resource_group_name = var.location
  location            = var.location
  address_space       = var.settings.address_space
  gateway_address     = try(var.settings.gateway_address, null)
  gateway_fqdn        = try(var.settings.gateway_fqdn, null)

  dynamic "bgp_settings" {
    for_each = try(var.settings.bgp_settings, {})
    content {
      asn             = each.value.asn
      peering_address = each.value.peering_address
      peer_weight     = each.value.peer_weight
    }
  }
}