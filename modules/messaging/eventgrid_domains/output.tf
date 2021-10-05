output "id" {
  description = "The Eventgrid Domain ID."
  value       = azurerm_eventgrid_domain.evgd.id
}

output "endpoint" {
  description = "The Endpoint for Eventgrid Domain."
  value       = azurerm_eventgrid_domain.evgd.endpoint
}

output "primary_access_key" {
  description = "The Eventgrid Domain primary_access_key."
  value       = azurerm_eventgrid_domain.evgd.primary_access_key
}

output "secondary_access_key" {
  description = "The Eventgrid Domain secondary_access_key."
  value       = azurerm_eventgrid_domain.evgd.secondary_access_key
}

// output "identity" {
//   description = "System assigned identity which is used by master components"
//   value       = azurerm_eventgrid_domain.evgd.identity
// }


// output "identity_type" {
//   value = try(azurerm_eventgrid_domain.evgd.identity.type, null)
// }

// output "identity_principal_id" {
//   value = try(azurerm_eventgrid_domain.evgd.identity.principal_id, null)
// }

// output "identity_tenant_id" {
//   value = try(azurerm_eventgrid_domain.evgd.identity.tenant_id, null)
// }

// output "identity_identity_ids" {
//   value = try(azurerm_eventgrid_domain.evgd.identity.identity_ids, null)
// }

output "name" {
  description = "The Eventgrid Domain name."
  value       = azurerm_eventgrid_domain.evgd.name
}



output "resource_group_name" {
  value       = var.resource_group_name
  description = "Name of the resource group"
}

