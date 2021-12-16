
module "backup_vaults" {
  source   = "./modules/backup_vault"
  for_each = var.backup_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  backup_vault        = each.value
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, {})
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

output "backup_vaults" {
  value = module.backup_vaults
}

module "backup_vault_policies" {
  source   = "./modules/backup_vault/backup_vault_policy"
  for_each = var.backup_vaults
  
  settings = each.value
  vault_id = module.backup_vaults[each.key].id
}
  
output "backup_vault_policies" {
  value = module.backup_vault_policies
}
  
module "backup_vault_instances" {
  source   = "./modules/backup_vault/backup_vault_instance"
  depends_on = [azurerm_role_assignment.for]
  for_each = var.backup_vaults

  settings = each.value
  vault_id           = module.backup_vaults[each.key].id
  location           = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  storage_account_id = try(module.storage_accounts[each.value.storage_account_key].id, null)
  #  backup_policy_id   = azurerm_data_protection_backup_policy_blob_storage.backup_vault_policy[each.value.backup_vault_policy_key].id
  backup_policy_id = try(module.backup_vault_policies[each.value.backup_vault_policy_key].id, null)

}

output "backup_vault_instances" {
  value = module.backup_vault_instances
}
