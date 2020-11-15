resource "azurecaf_name" "mariadb" {

  name          = var.settings.name
  resource_type = "azurerm_mariadb_database"
  prefixes      = [var.global_settings.prefix]
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_mariadb_database" "mariadb_database" {

  for_each = var.settings.mariadb_database

  name                = each.value.name
  resource_group_name = var.resource_group_name
  server_name         = azurerm_mariadb_server.mariadb.name
  charset             = each.value.charset
  collation           = each.value.collation
}

# threat detection policy

data "azurerm_storage_account" "mariadb_tdp" {
  count = try(var.settings.threat_detection_policy.storage_account.key, null) == null ? 0 : 1

  name                = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].name
  resource_group_name = var.storage_accounts[var.settings.threat_detection_policy.storage_account.key].resource_group_name
}