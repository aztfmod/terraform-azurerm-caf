output "id" {
  value       = azurerm_mssql_managed_instance.mssqlmi.id
  description = "SQL Managed instance Id"
}
output "name" {
  value       = data.azurecaf_name.mssqlmi.result
  description = "SQL MI Name"
}

output "location" {
  value = var.location
}

output "principal_id" {
  value       = try(azurerm_mssql_managed_instance.mssqlmi.identity.0.principal_id, null)
  description = "SQL MI Identity Principal Id"
}