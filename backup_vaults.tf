module "backup_vaults" {
  source   = "./modules/backup_vault"
  for_each = var.backup_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, {})
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  storage_accounts    = module.storage_accounts
  depends_on          = [module.role_assignment_azuread_users]
}

output "backup_vaults" {
  value = module.backup_vaults
}
