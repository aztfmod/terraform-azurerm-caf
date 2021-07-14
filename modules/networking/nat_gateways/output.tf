output "nat_gateways" {
  value       = azurerm_nat_gateway.nat_gateway
  description = "Nat Gateway object"
}
output "id" {
  value       = azurerm_nat_gateway.nat_gateway.id
  description = "Nat Gateway object id"
}
