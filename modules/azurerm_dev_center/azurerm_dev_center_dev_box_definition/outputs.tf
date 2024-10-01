output "dev_box_definition_id" {
  description = "The ID of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.example.id
}

output "dev_box_definition_name" {
  description = "The name of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.example.name
}

output "dev_box_definition_location" {
  description = "The location of the Dev Box Definition"
  value       = azurerm_dev_center_dev_box_definition.example.location
}
