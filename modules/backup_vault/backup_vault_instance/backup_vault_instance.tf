resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
  for_each = try (var.settings.backup_vault_instances, {})
  
  name               = var.settings.name
  vault_id           = var.vault_id #"/subscriptions/3f4dae7c-7085-45cc-a974-39c13903344c/resourceGroups/qs-rg-launchpad-level0-gdj/providers/Microsoft.DataProtection/backupVaults/qs-bckp-level0-gvp"
  location           = var.location #"South Central US"
  storage_account_id = var.storage_account_id #"/subscriptions/3f4dae7c-7085-45cc-a974-39c13903344c/resourceGroups/qs-rg-launchpad-level0-gdj/providers/Microsoft.Storage/storageAccounts/qsstlevel0skk"
  backup_policy_id   = var.backup_policy_id #"/subscriptions/3f4dae7c-7085-45cc-a974-39c13903344c/resourceGroups/qs-rg-launchpad-level0-gdj/providers/Microsoft.DataProtection/backupVaults/qs-bckp-level0-gvp/backupPolicies/back-policy"
}
