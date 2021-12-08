resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
#   for_each = try (var.settings.backup_vault_policies, {})
  for_each = try(var.backup_vault.backup_vault_policies, {})
  
  name               = var.settings.name
  vault_id           = azurerm_data_protection_backup_vault.backup_vault.id
  location           = var.location
  storage_account_id = var.storage_account_id 
  backup_policy_id   = module.backup_vault_policy[each.value].id 
}
