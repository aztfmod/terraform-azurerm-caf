output "id" {
  value       = azurerm_app_configuration.config.id
  description = "The ID of the App Config."
}

output "endpoint" {
  value       = azurerm_app_configuration.config.endpoint
  description = "The URL of the App Configuration."
}

output "identity" {
  value       = azurerm_app_configuration.config.identity
  description = "The managed service identity object."
}