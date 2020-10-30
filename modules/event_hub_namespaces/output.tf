output id {
  value     = azurerm_eventhub_namespace.evh.id
  sensitive = true
}

output name {
  value     = azurerm_eventhub_namespace.evh.name
  sensitive = true
}

output location {
  value     = azurerm_eventhub_namespace.evh.location
  sensitive = true
}