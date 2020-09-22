
output "id" {
  description = "Output the object ID"
  value       = azurerm_recovery_services_vault.asr_rg_vault.id
}

output "name" {
  description = "Output the object name"
  value       = azurerm_recovery_services_vault.asr_rg_vault.name
}

## need to export all backup policies, asr policies, etc.
