output "id" {
  value       = azurerm_eventgrid_system_topic.egt.id
  description = "The EventGrid System Topic ID."
}
output "name" {
  value       = azurerm_eventgrid_system_topic.egt.name
  description = "The EventGrid System Topic Name."
}
output "identity" {
  value       = azurerm_eventgrid_system_topic.egt.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid System Topic."
}
