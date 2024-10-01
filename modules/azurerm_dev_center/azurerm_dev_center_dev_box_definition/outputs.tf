output "dev_box_definition_id" {
  description = "The ID of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.dev_box_definition.id
}

output "dev_box_definition_name" {
  description = "The name of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.dev_box_definition.name
}

output "dev_box_definition_location" {
  description = "The location of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.dev_box_definition.location
}

output "dev_box_definition_resource_group_name" {
  description = "The name of the resource group containing the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.dev_box_definition.resource_group_name
}
