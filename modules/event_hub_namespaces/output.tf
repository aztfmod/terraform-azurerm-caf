output id {
  description = "The EventHub Namespace ID."
  value       = azurerm_eventhub_namespace.evh.id
  
}

output name {
  description = "The EventHub Namespace name."
  value       = azurerm_eventhub_namespace.evh.name
  
}

output location {
  description = "The EventHub Namespace location."
  value       = azurerm_eventhub_namespace.evh.location
  
}