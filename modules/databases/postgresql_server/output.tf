output "id" {
  value = azurerm_postgresql_server.postgresql.id
}

output "fqdn" {
  value = azurerm_postgresql_server.postgresql.fqdn
}

output "rbac_id" {
  value = try(azurerm_postgresql_server.postgresql.identity[0].principal_id, null)
}

output "identity" {
  value = try(azurerm_postgresql_server.postgresql.identity, null)
}

output "name" {
  value = azurecaf_name.postgresql.result
}

output "resource_group_name" {
  value = var.resource_group_name
}

output "location" {
  value = var.location
}
