output id {
  value = azurerm_mariadb_server.mariadb.id
}

# output rbac_id {
#   value = try(azurerm_mysql_server.mysql.identity[0].principal_id, null)
# }

# output identity {
#   value = try(azurerm_mysql_server.mysql.identity, null)
# }

output name {
  value = azurecaf_name.mariadb.result
}

output resource_group_name {
  value = var.resource_group_name
}

output location {
  value = var.location
}