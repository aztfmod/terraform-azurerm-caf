resource "azurecaf_name" "vngw_connection" {
  name          = var.settings.name
  resource_type = "azurerm_virtual_network_gateway"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_virtual_network_gateway_connection" "vngw_connection" {
  name                       = azurecaf_name.vngw_connection.result
  location                   = var.location
  resource_group_name        = var.resource_group_name
  type                       = var.settings.type
  virtual_network_gateway_id = var.virtual_network_gateway_id

  # The following arguments are applicable only if the type is ExpressRoute
  express_route_circuit_id = var.express_route_circuit_id
  authorization_key        = var.authorization_key

  # The following arguments are applicable only if the type is IPsec (VPN)
  connection_protocol      = try(var.settings.connection_method, null)
  shared_key               = try(var.settings.shared_key, null)
  enable_bgp               = try(var.settings.enable_bgp, null)
  local_network_gateway_id = try(var.settings.local_network_gateway_id, null)
  routing_weight           = try(var.settings.routing_weight, null)

  # The following arguments are applicable only if the type is Vnet2Vnet
  peer_virtual_network_gateway_id = try(var.settings.azurerm_virtual_network_gateway.id, null)
}