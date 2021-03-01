output id {
  value = azurerm_mssql_server.mssql.id
}

output rbac_id {
  value = try(azurerm_mssql_server.mssql.identity[0].principal_id, null)
}

output identity {
  value = try(azurerm_mssql_server.mssql.identity, null)
}

output azuread_administrator {
  value = try(azurerm_mssql_server.mssql.azuread_administrator, null)
}

output name {
  value = azurecaf_name.mssql.result
}

output resource_group_name {
  value = var.resource_group_name
}

output location {
  value = var.location
}

output administrator_login {
  value = var.settings.administrator_login
}

output administrator_login_password {
  value = try(var.settings.administrator_login_password, random_password.sql_admin.0.result)
}