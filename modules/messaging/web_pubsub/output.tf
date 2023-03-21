output "id" {
  description = "The ID of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.id
}

output "hostname" {
  description = "The hostname of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.name
}

output "public_port" {
  description = "The public_port of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.public_port
}

output "server_port" {
  description = "The server_port of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.server_port
}

output "primary_access_key" {
  description = "The primary_access_key of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.primary_access_key
}

output "primary_connection_string" {
  description = "The primary_connection_string of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.primary_connection_string
}

output "secondary_access_key" {
  description = "The secondary_access_key of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.secondary_access_key
}

output "secondary_connection_string" {
  description = "The secondary_connection_string of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.secondary_connection_string
}

output "location" {
  description = "The location of the Web PubSub service"
  value       = local.location
}

output "resource_group_name" {
  description = "The resource group name of the Web PubSub service"
  value       = azurerm_web_pubsub.wps.resource_group_name
}

output "identity" {
  description = " An identity block, which contains the Identity information for this Web PubSub service. Exports principal_id (The Principal ID for the Service Principal associated with the Identity of this Web PubSub service), tenand_id (The Tenant ID for the Service Principal associated with the Identity of this Web PubSub service)"
  value       = try(azurerm_web_pubsub.wps.identity, null)
}
