
output name {
  value       = azurecaf_name.mssqlmi.result
  description = "SQL MI Name"
}

output id {
  value       = lookup(azurerm_template_deployment.mssqlmi.outputs, "id")
  description = "SQL MI Id"
}

output location {
  value       = var.location
}