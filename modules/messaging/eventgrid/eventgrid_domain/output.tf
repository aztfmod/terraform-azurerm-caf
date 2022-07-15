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
  value       = azurerm_eventgrid_domain.egd.secondary_access_key
  description = "The Secondary Shared Access Key associated with the EventGrid Domain."
}
output "identity" {
  value       = azurerm_eventgrid_domain.egd.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Domain."
}
