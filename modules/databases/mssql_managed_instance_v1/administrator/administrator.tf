resource "azurerm_mssql_managed_instance_active_directory_administrator" "admin" {
  azuread_authentication_only = var.aad_only_auth
  login_username              = var.settings.login_username
  managed_instance_id         = var.managed_instance_id
  object_id                   = var.group_id
  tenant_id                   = var.tenant_id
}