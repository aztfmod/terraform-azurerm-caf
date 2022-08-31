resource "azurerm_postgresql_flexible_server_database" "postgresql" {
  depends_on = [azurerm_postgresql_flexible_server.postgresql]
  for_each   = try(var.settings.postgresql_databases, {})

  name      = each.value.name
  server_id = azurerm_postgresql_flexible_server.postgresql.id
  collation = try(each.value.collation, "en_US.utf8")
  charset   = try(each.value.charset, "utf8")
}

# Store the azurerm_postgresql_flexible_server_database_name into keyvault if the attribute keyvault{} is defined.
resource "azurerm_key_vault_secret" "postgresql_database_name" {
  for_each = { for key, value in var.settings.postgresql_databases : key => value if can(var.settings.keyvault) }

  name         = format("%s-ON-%s", each.value.name, azurecaf_name.postgresql_flexible_server.result)
  value        = each.value.name
  key_vault_id = var.remote_objects.keyvault_id
}
