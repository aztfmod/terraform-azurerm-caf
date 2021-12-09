resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
  for_each = try(var.settings.backup_vault_instances, {})
#   depends_on = [module.role_assignment_azuread_users]
  
  name               = each.value.name
  vault_id           = azurerm_data_protection_backup_vault.backup_vault.id
  location           = var.location
  storage_account_id = lookup(each.value, "storage_account_key") == null ? null : var.storage_accounts[each.value.storage_account_key].id
  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy[each.value.backup_vault_policy_key].id #module.backup_vault_policy[each.value].id 
}
