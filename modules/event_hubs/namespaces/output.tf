output "id" {
  description = "The EventHub Namespace ID."
  value       = azurerm_eventhub_namespace.evh.id
}

output "name" {
  description = "The EventHub Namespace name."
  value       = azurerm_eventhub_namespace.evh.name
}

output "resource_group_name" {
  value       = local.resource_group_name
  description = "Name of the resource group"
}

output "location" {
  value       = local.location
  description = "Location of the service"
}

output "tags" {
  value       = azurerm_eventhub_namespace.evh.tags
  description = "A mapping of tags to assign to the resource."
}

output "event_hubs" {
  value = module.event_hubs
}