output id {
  value     = azurerm_data_factory.df.id
  sensitive = true
}

output identity {
  value     = azurerm_data_factory.df.identity
  sensitive = true
}
