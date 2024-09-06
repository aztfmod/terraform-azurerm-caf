output "id" {
  description = "The ID of the Maintenance Configuration."
  value       = azurerm_maintenance_configuration.maintenance_configuration.id
}

output "maintenance_configuration_name" {
  description = "The name of the maintenance configuration."
  value       = azurerm_maintenance_configuration.maintenance_configuration.name
}

output "maintenance_configuration_location" {
  description = "The location where the resource exists"
  value       = azurerm_maintenance_configuration.maintenance_configuration.location
}