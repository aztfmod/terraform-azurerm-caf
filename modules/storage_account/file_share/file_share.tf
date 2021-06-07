# Tested with :  AzureRM version 2.61.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/storage_share

resource "azurerm_storage_share" "fs" {
  name                 = var.settings.name
  storage_account_name = var.storage_account_name
  quota                = try(var.settings.quota, null)
  metadata             = try(var.settings.metadata, null)
}

resource "azurerm_backup_protected_file_share" "fs_backup" {
  # depends_on = [azurerm_storage_share.fs]
  for_each = try(var.settings.backups, null) != null ? toset(["enabled"]) : toset([])

  resource_group_name       = var.resource_group_name
  recovery_vault_name       = var.recovery_vault.name
  source_storage_account_id = var.storage_account_id
  source_file_share_name    = azurerm_storage_share.fs.name
  backup_policy_id          = var.recovery_vault.backup_policies.file_shares[var.settings.backups.policy_key].id
}

