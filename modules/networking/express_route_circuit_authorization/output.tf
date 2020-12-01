output id {
  value       = azurerm_express_route_circuit_authorization.circuitauth.id
  sensitive   = false
  description = "Express Route Circuit Authorization ID"
}
output authorization_key {
  value       = azurerm_express_route_circuit_authorization.circuitauth.authorization_key
  sensitive   = false
  description = "The authorization key"
}
output authorization_use_status {
  value       = azurerm_express_route_circuit_authorization.circuitauth.authorization_use_status
  sensitive   = false
  description = "The authorization use status."
}