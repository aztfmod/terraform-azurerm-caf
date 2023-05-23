
output "name" {
  value       = azurecaf_name.manageddb.result
  description = "SQL Managed DB Name"
}

output "id" {
  value       = jsondecode(azurerm_resource_group_template_deployment.manageddb.output_content).id.value
  description = "SQL Managed DB Id"
}
