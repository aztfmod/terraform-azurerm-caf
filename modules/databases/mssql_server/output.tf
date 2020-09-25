output id {
  value = azurerm_mssql_server.mssql.id
}

output rbac_id {
  value = azurerm_mssql_server.mssql.identity[0].principal_id
}