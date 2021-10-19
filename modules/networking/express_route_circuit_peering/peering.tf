resource "azurerm_express_route_circuit_peering" "circuitpeering" {
  
  peering_type                  = var.settings.peering_type
  express_route_circuit_name    = var.express_route_circuit_name
  resource_group_name           = var.resource_group_name
  primary_peer_address_prefix   = var.settings.primary_peer_address_prefix
  secondary_peer_address_prefix = var.settings.secondary_peer_address_prefix
  vlan_id                       = var.settings.vlan_id
  peer_asn                      = try(var.settings.peer_asn,null)
  shared_key                    = try(var.settings.shared_key,null)
  
  #The ID of the Route Filter. Only available when peering_type is set to MicrosoftPeering.
  route_filter_id               = try(var.settings.route_filter_id,null)

  dynamic "microsoft_peering_config" {
 
    for_each = lookup(var.settings, "microsoft_peering_config", null) == null ? [] : [1]
 
    content {
      advertised_public_prefixes = [each.value.microsoft_peering_config.advertised_public_prefixes]
      routing_registry_name      = try(each.value.microsoft_peering_config.routing_registry_name,null)
      customer_asn               = try(each.value.microsoft_peering_config.customer_asn,null)
    }
  }
}