output "id" {
  value = azurerm_iothub.iothub.id
}

output "name" {
  value = azurerm_iothub.iothub.name
}

output "location" {
  value = azurerm_iothub.iothub.location
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

output "event_hub_events_namespace" {
  value = azurerm_iothub.iothub.event_hub_events_namespace
}

output "identity" {
  value = try(azurerm_iothub.iothub.identity, null)
}
