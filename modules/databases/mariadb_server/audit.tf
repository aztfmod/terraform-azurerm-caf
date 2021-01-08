# Server auditing

data "azurerm_storage_account" "mariadb_auditing" {
  count = try(var.settings.extended_auditing_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.extended_auditing_policy.storage_account.key].resource_group_name
}