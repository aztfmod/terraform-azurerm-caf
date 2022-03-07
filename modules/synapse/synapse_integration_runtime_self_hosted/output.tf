output "id" {
  value = azurerm_synapse_integration_runtime_self_hosted.syiesh.id
  description = "The ID of the Synapse Self-hosted Integration Runtime."
}
output "authorization_key_primary" {
  value = azurerm_synapse_integration_runtime_self_hosted.syiesh.authorization_key_primary
  description = "The primary integration runtime authentication key."
}
output "authorization_key_secondary" {
  value = azurerm_synapse_integration_runtime_self_hosted.syiesh.authorization_key_secondary
  description = "The secondary integration runtime authentication key."
}
