
output "name" {
  value       = azurecaf_name.mssqlmi.result
  description = "SQL MI Name"
}

output "id" {
  value       = jsondecode(azurerm_resource_group_template_deployment.mssqlmi.output_content).id.value
  description = "SQL MI Id"
}

output "location" {
  value = var.location
}

output "principal_id" {
  value       = jsondecode(azurerm_resource_group_template_deployment.mssqlmi.output_content).objectId.value
  description = "SQL MI Identity Principal Id"
}