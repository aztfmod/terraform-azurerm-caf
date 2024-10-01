output "project_environment_type_id" {
  description = "The ID of the Project Environment Type."
  value       = azurerm_dev_center_project_environment_type.project_environment_type.id
}

output "project_environment_type_name" {
  description = "The name of the Project Environment Type."
  value       = azurerm_dev_center_project_environment_type.project_environment_type.name
}

output "project_environment_type_location" {
  description = "The location of the Project Environment Type."
  value       = azurerm_dev_center_project_environment_type.project_environment_type.location
}

output "project_environment_type_resource_group_name" {
  description = "The name of the resource group containing the Project Environment Type."
  value       = azurerm_dev_center_project_environment_type.project_environment_type.resource_group_name
}
