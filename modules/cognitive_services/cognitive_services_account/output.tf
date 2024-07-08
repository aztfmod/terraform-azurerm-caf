output "id" {
  description = "The ID of the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.id
}

output "endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.endpoint
}

output "rbac_id" {
  description = "The Principal ID of the Cognetive Services for Role Mapping"
  value       = try(azurerm_cognitive_account.service.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_cognitive_account.service.identity, null)
}