output id {
  value = azurerm_synapse_workspace.ws.id
}

output rbac_id {
  value = azurerm_synapse_workspace.ws.identity[0].principal_id
}
