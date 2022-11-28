output "id" {
  value = azurerm_express_route_circuit_peering.peering.id
}

output "azure_asn" {
  value = azurerm_express_route_circuit_peering.peering.azure_asn
}

output "primary_azure_port" {
  value = azurerm_express_route_circuit_peering.peering.primary_azure_port
}

output "secondary_azure_port" {
  value = azurerm_express_route_circuit_peering.peering.secondary_azure_port
}

