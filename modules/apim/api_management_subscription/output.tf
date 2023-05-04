output "id" {
  value       = azurerm_api_management_subscription.apim.id
  description = "The ID of the API Management subscription."
}

output "primary_key" {
  value       = azurerm_api_management_subscription.apim.primary_key
  description = "The primary subscription key to use for the subscription."
  sensitive   = true
}

output "secondary_key" {
  value       = azurerm_api_management_subscription.apim.secondary_key
  description = "The secondary subscription key to use for the subscription."
  sensitive   = true
}