output "id" {
  value       = azurerm_app_configuration.config.id
  description = "The ID of the App Config."
}

output "endpoint" {
  value       = azurerm_app_configuration.config.endpoint
  description = "The URL of the App Configuration."
}

output "identity" {
  value       = try(azurerm_app_configuration.config.identity, null)
  description = "The managed service identity object."
}

output "rbac_id" {
  value       = try(azurerm_app_configuration.config.identity[0].principal_id, null)
  description = "The rbac_id of the App Config for role assignments."
}