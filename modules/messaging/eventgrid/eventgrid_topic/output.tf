output "id" {
  value       = azurerm_eventgrid_topic.egt.id
  description = "The EventGrid Topic ID."
}
output "endpoint" {
  value       = azurerm_eventgrid_topic.egt.endpoint
  description = "The Endpoint associated with the EventGrid Topic."
}
output "primary_access_key" {
  value       = azurerm_eventgrid_topic.egt.primary_access_key
  description = "The Primary Shared Access Key associated with the EventGrid Topic."
}
output "secondary_access_key" {
  value       = azurerm_eventgrid_topic.egt.secondary_access_key
  description = "The Secondary Shared Access Key associated with the EventGrid Topic."
}
output "identity" {
  value       = azurerm_eventgrid_topic.egt.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Topic."
}
