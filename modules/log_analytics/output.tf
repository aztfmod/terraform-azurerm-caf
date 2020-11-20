output id {
  value     = azurerm_log_analytics_workspace.law.id
  sensitive = true
}

output location {
  value     = azurerm_log_analytics_workspace.law.location
  sensitive = true
}

output name {
  value     = azurerm_log_analytics_workspace.law.name
  sensitive = true
}

output resource_group_name {
  value     = azurerm_log_analytics_workspace.law.resource_group_name
  sensitive = true
}

output workspace_id {
  value       = azurerm_log_analytics_workspace.law.workspace_id
  sensitive = true
}
