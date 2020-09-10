output id {
  value = azurerm_synapse_workspace.wp.id
}

output rbac_id {
  value = azurerm_synapse_workspace.wp.identity[0].principal_id
}
