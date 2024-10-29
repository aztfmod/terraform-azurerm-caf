output "id" {
  description = "The ID of the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.id
}

output "endpoint" {
  description = "The endpoint used to connect to the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.endpoint
}

output "identity" {
  description = "The identity associated with the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.identity
}

output "identity_principal_id" {
  description = "The Principal ID associated with the identity of the Cognitive Service Account."
  value       = try(azurerm_cognitive_account.service.identity[0].principal_id, null)
}

output "identity_tenant_id" {
  description = "The Tenant ID associated with the identity of the Cognitive Service Account."
  value       = try(azurerm_cognitive_account.service.identity[0].tenant_id, null)
}

output "primary_access_key" {
  description = "The primary access key associated with the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.primary_access_key
}

output "secondary_access_key" {
  description = "The secondary access key associated with the Cognitive Service Account."
  value       = azurerm_cognitive_account.service.secondary_access_key
}