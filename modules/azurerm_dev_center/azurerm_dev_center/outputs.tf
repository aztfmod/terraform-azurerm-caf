output "dev_center_id" {
  description = "The ID of the Dev Center."
  value       = azurerm_dev_center.example.id
}

output "dev_center_name" {
  description = "The name of the Dev Center."
  value       = azurerm_dev_center.example.name
}

output "dev_center_location" {
  description = "The location of the Dev Center."
  value       = azurerm_dev_center.example.location
}

output "dev_center_resource_group_name" {
  description = "The name of the resource group containing the Dev Center."
  value       = azurerm_dev_center.example.resource_group_name
}
