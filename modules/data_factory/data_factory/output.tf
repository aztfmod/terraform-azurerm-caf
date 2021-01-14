output id {
  value     = azurerm_data_factory.df.id
  sensitive = true
}

output name {
  value    = azurerm_data_factory.df.name
}

output identity {
  value     = azurerm_data_factory.df.identity
  sensitive = true
}
