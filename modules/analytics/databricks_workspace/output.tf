output id {
  value     = azurerm_databricks_workspace.ws.id
  sensitive = true
}

output managed_resource_group_id {
  value     = azurerm_databricks_workspace.ws.managed_resource_group_id
  sensitive = true
}

output workspace_url {
  value     = azurerm_databricks_workspace.ws.workspace_url
  sensitive = true
}

output workspace_id {
  value     = azurerm_databricks_workspace.ws.workspace_id
  sensitive = true
}
