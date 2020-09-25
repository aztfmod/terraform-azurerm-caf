output id {
  value = azurerm_mssql_server.mssql.id
}

output rbac_id {
  value = try(azurerm_mssql_server.mssql.identity[0].principal_id, null)
}

output identity {
  value = try(azurerm_mssql_server.mssql.identity, null)
}

output azuread_administrator  {
  value = try(azurerm_mssql_server.mssql.azuread_administrator , null)
}