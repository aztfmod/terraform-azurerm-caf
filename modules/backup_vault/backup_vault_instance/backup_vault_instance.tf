resource "azurerm_data_protection_backup_instance_blob_storage" "backup_vault_instance" {
  for_each = try(var.settings.backup_vault_instances, {})
  
  name               = each.value.instance_name
#   name               = var.settings.name
  vault_id           = var.vault_id
  location           = var.location
  storage_account_id = each.value.storage_account_key
  backup_policy_id   = each.value.backup_vault_policy_key
}
