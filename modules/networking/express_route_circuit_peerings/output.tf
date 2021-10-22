output "id" {
  value       = azurerm_express_route_circuit_peering.circuitpeering.id
  description = "ExpressRoute Circuit Peering ID"
}
output "azure_asn" {
  value       = azurerm_express_route_circuit_peering.circuitpeering.azure_asn
  description = "The ASN used by Azure"
}
output "primary_azure_port" {
  value       = azurerm_express_route_circuit_peering.circuitpeering.primary_azure_port
  description = "The Primary Port used by Azure for this Peering."
}
output "secondary_azure_port" {
  value       = azurerm_express_route_circuit_peering.circuitpeering.secondary_azure_port
  description = "The Secondary Port used by Azure for this Peering."
}
