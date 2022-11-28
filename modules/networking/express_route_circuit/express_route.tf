resource "azurecaf_name" "circuit" {
  name          = var.settings.name
  resource_type = "azurerm_express_route_circuit"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_express_route_circuit" "circuit" {

  name                  = azurecaf_name.circuit.result
  resource_group_name   = var.resource_group_name
  location              = var.location
  tags                  = local.tags
  service_provider_name = try(var.settings.service_provider_name, "Equinix")
  peering_location      = try(var.settings.peering_location, "Silicon Valley")
  bandwidth_in_mbps     = try(var.settings.bandwidth_in_mbps, 50)
  express_route_port_id = try(var.settings.express_route_port_id, null)
  bandwidth_in_gbps     = try(var.settings.bandwidth_in_gbps, null)

  sku {
    tier   = try(var.settings.tier, "Standard")
    family = try(var.settings.family, "MeteredData")
  }
}
