
output "name" {
  value       = azurecaf_name.manageddb.result
  description = "SQL Managed DB Name"
}

output "id" {
  value       = azurerm_resource_group_template_deployment.manageddb.id
  description = "SQL Managed DB Id"
}
