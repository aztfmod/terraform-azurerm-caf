output "id" {
  value       = azurerm_data_factory_integration_runtime_self_hosted.dfirsh.id
  description = "The ID of the Data Factory."
}
# output "auth_key_1" {
#   value = azurerm_data_factory_integration_runtime_self_hosted.dfirsh.auth_key_1
#   description = "The primary integration runtime authentication key."
# }
# output "auth_key_2" {
#   value = azurerm_data_factory_integration_runtime_self_hosted.dfirsh.auth_key_2
#   description = "The secondary integration runtime authentication key."
# }
