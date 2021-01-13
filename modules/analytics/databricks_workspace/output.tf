output id {
  description = "The ID of the Databricks Workspace in the Azure management plane."
  value       = azurerm_databricks_workspace.ws.id
  sensitive   = true
}

output managed_resource_group_id {
  description = "The ID of the Managed Resource Group created by the Databricks Workspace."
  value       = azurerm_databricks_workspace.ws.managed_resource_group_id
  sensitive   = true
}

output workspace_url {
  description = "The workspace URL which is of the format 'adb-{workspaceId}.{random}.azuredatabricks.net'"
  value       = azurerm_databricks_workspace.ws.workspace_url
  sensitive   = true
}

output workspace_id {
  description = "The unique identifier of the databricks workspace in Databricks control plane."
  value       = azurerm_databricks_workspace.ws.workspace_id
  sensitive   = true
}