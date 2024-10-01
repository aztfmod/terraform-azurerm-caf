output "environment_type_id" {
  description = "The ID of the Environment Type."
  value       = azurerm_dev_center_environment_type.environment_type.id
}

output "environment_type_name" {
  description = "The name of the Environment Type."
  value       = azurerm_dev_center_environment_type.environment_type.name
}

output "environment_type_location" {
  description = "The location of the Environment Type."
  value       = azurerm_dev_center_environment_type.environment_type.location
}

output "environment_type_resource_group_name" {
  description = "The name of the resource group containing the Environment Type."
  value       = azurerm_dev_center_environment_type.environment_type.resource_group_name
}
