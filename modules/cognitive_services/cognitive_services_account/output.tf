output "id" {
  description = "The ID of the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.id
}

output "endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.endpoint
}

output "primary_access_key" {
  description = "The primary_access_key used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.primary_access_key
}

output "secondary_access_key" {
  description = "The secondary_access_key used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.secondary_access_key
}

output "rbac_id" {
  description = "The Principal ID of the Cognetive Services for Role Mapping"
  value       = try(azurerm_cognitive_account.service.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_cognitive_account.service.identity, null)
}
