module "backup_vault_policies" {
  source   = "./backup_vault_policy"
  for_each = try(var.settings.backup_vault_policies, {})
  
  settings = each.value
  vault_id = azurerm_data_protection_backup_vault.backup_vault.id  
}
