output "id" {
  value = azurerm_iothub.iothub.id
}

output "hostname" {
  value = azurerm_iothub.iothub.hostname
}

output "event_hub_events_endpoint" {
  value = azurerm_iothub.iothub.event_hub_events_endpoint
}

output "event_hub_events_path" {
  value = azurerm_iothub.iothub.event_hub_events_path
}

output "event_hub_operations_endpoint" {
  value = azurerm_iothub.iothub.event_hub_operations_endpoint
}

output "event_hub_operations_path" {
  value = azurerm_iothub.iothub.event_hub_operations_path
}

# >= 2.92.0
# output "event_hub_events_namespace" {
#   value = azurerm_iothub.iothub.event_hub_events_namespace
# }
