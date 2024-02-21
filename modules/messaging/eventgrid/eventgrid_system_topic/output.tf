output "id" {
  value       = azurerm_eventgrid_system_topic.egst.id
  description = "The EventGrid System Topic ID."
}
output "name" {
  value       = azurerm_eventgrid_system_topic.egst.name
  description = "The EventGrid System Topic Name."
}
output "resource_group_name" {
  value       = azurerm_eventgrid_system_topic.egst.resource_group_name
  description = "The EventGrid  System Topic Resource Group Name."
}
output "endpoint" {
  value       = azurerm_eventgrid_system_topic.egst.metric_arm_resource_id
  description = "The Metric ARM Resource ID of the Event Grid System Topic."
}
output "identity" {
  value       = azurerm_eventgrid_system_topic.egst.identity
  description = "An `identity` block as defined below, which contains the Managed Service Identity information for this Event Grid Topic."
}
