output "id" {
  value = azurerm_mysql_server.mysql.id
}

output "fqdn" {
  value = azurerm_mysql_server.mysql.fqdn
}

output "rbac_id" {
  value = try(azurerm_mysql_server.mysql.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_mysql_server.mysql.identity, null)
}

output "name" {
  value = azurecaf_name.mysql.result
}


output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}