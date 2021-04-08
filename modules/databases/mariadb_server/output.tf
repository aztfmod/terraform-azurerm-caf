output "id" {
  value = azurerm_mariadb_server.mariadb.id
}

output "fqdn" {
  value = azurerm_mariadb_server.mariadb.fqdn
}

output "name" {
  value = azurecaf_name.mariadb.result
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
