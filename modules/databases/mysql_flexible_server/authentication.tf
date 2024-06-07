resource "azurerm_mysql_flexible_server_active_directory_administrator" "mysql" {
  for_each = try(var.settings.mysql_aad_admins, {})


  server_id   = azurerm_mysql_flexible_server.mysql.id
  identity_id = each.value.managed_identity_id
  login       = each.value.admin_group
  object_id   = each.value.admin_group_object_id
  tenant_id   = each.value.admin_group_tenant_id
}
