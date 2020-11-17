data "azurerm_client_config" "current" {}

resource "azurerm_mysql_active_directory_administrator" "mysql_ad_admin" {
  for_each = try(var.settings.mysql_ad_admin, {})
  
  server_name         = azurerm_mysql_server.mysql.name
  resource_group_name = var.resource_group_name
  login               = each.value.login
  tenant_id           = each.value.tenant_id
  object_id           = each.value.object_id
}