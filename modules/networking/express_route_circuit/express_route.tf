resource "azurecaf_name" "circuit" {
  name          = var.settings.name
  resource_type = "azurerm_express_route_circuit"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
}

resource "azurerm_express_route_circuit" "circuit" {

  name                  = azurecaf_name.circuit.result
  resource_group_name   = var.resource_group_name
  location              = var.location
  tags                  = local.tags
  service_provider_name = try(var.settings.service_provider_name, "Equinix")
  peering_location      = try(var.settings.peering_location, "Silicon Valley")
  bandwidth_in_mbps     = try(var.settings.bandwidth_in_mbps, 50)

  sku {
    tier   = try(var.settings.tier, "Standard")
    family = try(var.settings.family, "MeteredData")
  }
}

# resource "azurerm_express_route_circuit_authorization" "circuitauth" {
#   name                       = azurecaf_name.circuitauth.result
#   express_route_circuit_name = azurerm_express_route_circuit.circuit.name
#   resource_group_name        = var.resource_group_name
# }
