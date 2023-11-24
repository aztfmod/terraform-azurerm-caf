resource "azurerm_container_app_environment_storage" "caes" {
  name                         = var.settings.name
  container_app_environment_id = var.container_app_environment_id
  account_name                 = can(var.settings.account_name) ? var.settings.account_name : var.combined_resources.storage_accounts[try(var.settings.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.storage_account.account_key].name
  share_name                   = var.settings.share_name
  access_key                   = can(var.settings.access_key) ? var.settings.access_key : var.combined_resources.storage_accounts[try(var.settings.storage_account.lz_key, var.client_config.landingzone_key)][var.settings.storage_account.account_key].primary_access_key
  access_mode                  = var.settings.access_mode
}
