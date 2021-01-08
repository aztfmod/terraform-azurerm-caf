output id {
  description = "The EventHub Namespace ID."
  value       = azurerm_eventhub_namespace.evh.id
  sensitive   = true
}

output name {
  description = "The EventHub Namespace name."
  value       = azurerm_eventhub_namespace.evh.name
  sensitive   = true
}

output location {
  description = "The EventHub Namespace location."
  value       = azurerm_eventhub_namespace.evh.location
  sensitive   = true
}