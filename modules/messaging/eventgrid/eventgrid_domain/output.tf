output "name" {
  value       = azurerm_eventgrid_domain.egd.name
  description = "The Name of the EventGrid Domain."
}

output "id" {
  value       = azurerm_eventgrid_domain.egd.id
  description = "The ID of the EventGrid Domain."
}

output "endpoint" {
  value       = azurerm_eventgrid_domain.egd.endpoint
  description = "The Endpoint associated with the EventGrid Domain."
}

output "primary_access_key" {
  value       = azurerm_eventgrid_domain.egd.primary_access_key
  description = "The Primary Shared Access Key associated with the EventGrid Domain."
}

output "secondary_access_key" {
  value       = azurerm_eventgrid_domain.egd.primary_access_key
  description = "The Secondary Shared Access Key associated with the EventGrid Domain."
}

output "identity_type" {
  value       = try(azurerm_eventgrid_domain.egd.identity[0].type, null)
  description = "Specifies the type of Managed Service Identity that is configured on this Event Grid Domain."
}

output "identity_principal_id" {
  value       = try(azurerm_eventgrid_domain.egd.identity[0].principal_id, null)
  description = "Specifies the Principal ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain."
}


output "tenant_id" {
  value       = try(azurerm_eventgrid_domain.egd.identity[0].tenant_id, null)
  description = "Specifies the Tenant ID of the System Assigned Managed Service Identity that is configured on this Event Grid Domain."
}

output "identity_ids" {
  value = flatten([
    for identity in azurerm_eventgrid_domain.egd[*].identity : identity[*].identity_ids
  ])
  #value =  azurerm_eventgrid_domain.egd.identity[0].identity_ids
  description = "A list of IDs for User Assigned Managed Identity resources to be assigned."
}


output "identity" {
  value       = try(azurerm_eventgrid_domain.egd.identity, null)
  description = "All outputs of block identity."
}
