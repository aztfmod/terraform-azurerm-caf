output "id" {
  description = "The EventHub Namespace ID."
  value       = azurerm_eventgrid_topic.evgt.id
}

output "endpoint" {
  description = "The Endpoint for Eventgrid Topic."
  value       = azurerm_eventgrid_topic.evgt.endpoint
}

output "primary_access_key" {
  description = "The Eventgrid Topic primary_access_key."
  value       = azurerm_eventgrid_topic.evgt.primary_access_key
}

output "secondary_access_key" {
  description = "The Eventgrid Topic secondary_access_key."
  value       = azurerm_eventgrid_topic.evgt.secondary_access_key
}

// output "identity" {
//   description = "System assigned identity which is used by master components"
//   value       = azurerm_eventgrid_topic.evgt.identity
// }


// output "identity_type" {
//   value = try(azurerm_eventgrid_topic.evgt.identity.type, null)
// }

// output "identity_principal_id" {
//   value = try(azurerm_eventgrid_topic.evgt.identity.principal_id, null)
// }

// output "identity_tenant_id" {
//   value = try(azurerm_eventgrid_topic.evgt.identity.tenant_id, null)
// }

// output "identity_identity_ids" {
//   value = try(azurerm_eventgrid_topic.evgt.identity.identity_ids, null)
// }

output "name" {
  description = "The Eventgrid Topic name."
  value       = azurerm_eventgrid_topic.evgt.name
}



output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

