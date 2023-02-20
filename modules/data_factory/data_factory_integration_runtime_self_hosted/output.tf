output "id" {
  value       = azurerm_data_factory_integration_runtime_self_hosted.dfirsh.id
  description = "The ID of the Data Factory runtime."
}
output "name" {
  value       = azurecaf_name.dfirsh.result
  description = "The name of the Data Factory runtime."
}
