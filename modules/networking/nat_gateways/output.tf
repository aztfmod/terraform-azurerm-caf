output "nat_gateways_resource_guid" {
  value       = azurerm_nat_gateway.nat_gateway.resource_guid
  description = "Nat Gateway object"
}
output "id" {
  value       = azurerm_nat_gateway.nat_gateway.id
  description = "Nat Gateway object id"
}
