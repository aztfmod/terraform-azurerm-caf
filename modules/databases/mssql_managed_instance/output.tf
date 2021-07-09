
output "name" {
  value       = azurecaf_name.mssqlmi.result
  description = "SQL MI Name"
}

output "id" {
  value       = lookup(azurerm_template_deployment.mssqlmi.outputs, "id")
  description = "SQL MI Id"
}

output "location" {
  value = var.location
}

output "principal_id" {
  value       = lookup(azurerm_template_deployment.mssqlmi.outputs, "objectId")
  description = "SQL MI Identity Principal Id"
}