output id {
  value     = azurerm_eventhub.evhub.id
  sensitive = true
}

output name {
  description = "The EventHub name."
  value       = azurerm_eventhub.evhub.name
}