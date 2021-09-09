output "id" {
  value = azurerm_communication_service.acs.id

}

output "name" {
  value = azurecaf_name.acs.result
}

output "resource_group_name" {
  value       = var.resource_group_name
  description = "Resource group name is exported to allow the data source to retrieve the communication service attributes if needed."
}
