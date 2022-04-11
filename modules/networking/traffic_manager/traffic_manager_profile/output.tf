output "id" {
  description = "The ID of the Traffic Manager Profile"
  value       = azurerm_traffic_manager_profile.traffic_manager_profile.id
}

output "traffic_routing_method" {
  description = "Specifies the algorithm used to route traffic"
  value       = azurerm_traffic_manager_profile.traffic_manager_profile.traffic_routing_method
}

output "fqdn" {
  description = "The FQDN of the created Profile"
  value       = azurerm_traffic_manager_profile.traffic_manager_profile.fqdn
}
output "name" {
  description = "The FQDN of the created Profile"
  value       = azurerm_traffic_manager_profile.traffic_manager_profile.name
}