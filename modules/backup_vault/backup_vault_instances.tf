module "backup_vault_instance" {
  source     = "./backup_vault_instance"
  for_each   = try(var.settings.backup_vault_instances, {})

  settings                = each.value
  vault_id                = azurerm_data_protection_backup_vault.backup_vault.id
  location                = var.location
  storage_account_id_test = var.storage_account_id
  backup_policy_id        = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy.id
}
