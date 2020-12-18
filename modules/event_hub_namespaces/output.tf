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

output connection_string_primary {
  value = azurerm_eventhub_namespace.evh.default_primary_connection_string
}

output connection_string_secondary {
  value = azurerm_eventhub_namespace.evh.default_secondary_connection_string
}

output primary_key {
  value = azurerm_eventhub_namespace.evh.default_primary_key
}

output secondary_key {
  value = azurerm_eventhub_namespace.evh.default_secondary_key
}