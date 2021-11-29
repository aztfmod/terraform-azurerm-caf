module "backup_vaults" {
  source   = "./modules/backup_vault"
  for_each = var.backup_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
#   backup_vault        = each.value
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, {})
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

module "backup_vault_policies" {
  source   = "./modules/backup_vault/backup_vault_policy"
  for_each = var.backup_vault_policies

  global_settings = local.global_settings
  client_config   = local.client_config

  backup_vault_key      = each.key
  backup_vault_policies = each.value
  retention_duration    = try(each.value.retention_duration, {})
}

output "backup_vaults" {
  value = module.backup_vaults
}
