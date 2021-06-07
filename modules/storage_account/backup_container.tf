# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/backup_container_storage_account

locals {
  recovery_vault = try(var.storage_account.backup, null) == null ? null : try(var.recovery_vaults[var.client_config.landingzone_key][var.storage_account.backup.vault_key], var.recovery_vaults[var.storage_account.backup.lz_key][var.storage_account.backup.vault_key])
}

resource "azurerm_backup_container_storage_account" "container" {

  for_each = try(var.storage_account.backup, null) == null ? toset([]) : toset(["enabled"])


  resource_group_name = local.recovery_vault.resource_group_name
  recovery_vault_name = local.recovery_vault.name
  storage_account_id  = azurerm_storage_account.stg.id
}
