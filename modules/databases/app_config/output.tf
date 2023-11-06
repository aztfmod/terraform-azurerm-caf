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

output "primary_read_key_connection_string" {
  value       = azurerm_app_configuration.config.primary_read_key
  description = "The Connection String for the primary read access key - comprising of the Endpoint, ID and Secret."
}

output "primary_write_key_connection_string" {
  value       = azurerm_app_configuration.config.primary_write_key
  description = "The Connection String for the primary write access key - comprising of the Endpoint, ID and Secret."
}

output "secondary_read_key_connection_string" {
  value       = azurerm_app_configuration.config.secondary_read_key
  description = "The Connection String for the secondary read access key - comprising of the Endpoint, ID and Secret."
}

output "secondary_write_key_connection_string" {
  value       = azurerm_app_configuration.config.secondary_write_key
  description = "The Connection String for the secondary write access key - comprising of the Endpoint, ID and Secret."
}
