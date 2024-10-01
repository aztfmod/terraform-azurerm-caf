output "project_id" {
  description = "The ID of the Dev Center Project."
  value       = azurerm_dev_center_project.project.id
}

output "project_name" {
  description = "The name of the Dev Center Project."
  value       = azurerm_dev_center_project.project.name
}

output "project_location" {
  description = "The location of the Dev Center Project."
  value       = azurerm_dev_center_project.project.location
}

output "project_resource_group_name" {
  description = "The name of the resource group containing the Dev Center Project."
  value       = azurerm_dev_center_project.project.resource_group_name
}
