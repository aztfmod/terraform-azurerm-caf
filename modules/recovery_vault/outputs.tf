
output "id" {
  description = "Output the object ID"
  value       = azurerm_recovery_services_vault.asr_rg_vault.id
}

output "name" {
  description = "Output the object name"
  value       = azurerm_recovery_services_vault.asr_rg_vault.name
}

output "object" {
  description = "Output the full object"
  value       = azurerm_recovery_services_vault.asr_rg_vault
}


## need to export all backup policies, asr policies, etc.