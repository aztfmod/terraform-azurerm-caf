output id {
  value = azurerm_mariadb_server.mariadb.id
}

output name {
  value = azurecaf_name.mariadb.result
}

output resource_group_name {
  value = var.resource_group_name
}

output location {
  value = var.location
}
