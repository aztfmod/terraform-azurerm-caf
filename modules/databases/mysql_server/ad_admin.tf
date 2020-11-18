data "azurerm_client_config" "current" {}

resource "azurerm_mysql_active_directory_administrator" "mysql_ad_admin" {
  for_each = try(var.settings.azuread_administrator, {})
  
  server_name         = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group_name
  login               = try(var.settings.azuread_administrator.login_username, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].name)
  tenant_id           = try(var.settings.azuread_administrator.tenant_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].tenant_id)
  object_id           = try(var.settings.azuread_administrator.object_id, var.azuread_groups[var.settings.azuread_administrator.azuread_group_key].id)
}