output "id" {
  value       = azurerm_eventgrid_event_subscription.eges.id
  description = "The ID of the EventGrid Event Subscription."
}
output "topic_name" {
  value       = azurerm_eventgrid_event_subscription.eges.topic_name
  description = " Specifies the name of the topic to associate with the event subscription."
}
