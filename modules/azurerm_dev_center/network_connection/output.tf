output "network_connection_id" {
  description = "The ID of the Network Connection."
  value       = azurerm_dev_center_network_connection.network_connection.id
}

output "network_connection_name" {
  description = "The name of the Network Connection."
  value       = azurerm_dev_center_network_connection.network_connection.name
}

output "network_connection_location" {
  description = "The location of the Network Connection."
  value       = azurerm_dev_center_network_connection.network_connection.location
}

output "network_connection_resource_group_name" {
  description = "The name of the resource group containing the Network Connection."
  value       = azurerm_dev_center_network_connection.network_connection.resource_group_name
}
