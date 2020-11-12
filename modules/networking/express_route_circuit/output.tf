output id {
  value       = azurerm_express_route_circuit.circuit.id
  sensitive   = false
  description = "Express Route Circuit ID"
}
output service_key {
  value       = azurerm_express_route_circuit.circuit.service_key
  sensitive   = false
  description = "The string needed by the service provider to provision the ExpressRoute circuit."
}
output service_provider_provisioning_state {
  value       = azurerm_express_route_circuit.circuit.service_provider_provisioning_state
  sensitive   = false
  description = "The ExpressRoute circuit provisioning state from your chosen service provider."
}
output resource_group_name {
  value       = var.resource_group_name
  sensitive   = false
  description = "The Express Route circuit resource group name."
}
output name {
  value       = azurerm_express_route_circuit.circuit.name
  sensitive   = false
  description = "Name of the Express Route Circuit."
}