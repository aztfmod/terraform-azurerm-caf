output id {
  value     = azurerm_log_analytics_workspace.law.id
  sensitive = true
}

output location {
  value     = azurerm_log_analytics_workspace.law.location
  sensitive = true
}