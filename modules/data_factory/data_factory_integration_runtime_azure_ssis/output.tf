output "id" {
  value       = azurerm_data_factory_integration_runtime_azure_ssis.dfiras.id
  description = "The ID of the Data Factory Azure-SSIS Integration Runtime."
}
output "name" {
  value       = azurecaf_name.dfiras.result
  description = "The name of the Data Factory Azure-SSIS Integration Runtime."
}
