resource "azurerm_data_protection_backup_policy_blob_storage" "backup_vault_policy" {
#   for_each = try(var.settings.backup_vault_policies, {})
  
  name               = each.value.name
#   name               = var.settings.name
  vault_id           = var.vault_id
  retention_duration = try(var.settings.retention_duration, "P30D")
#   retention_duration = try(each.value.retention_duration, "P30D")
}
