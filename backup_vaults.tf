
module "backup_vaults" {
  source   = "./modules/backup_vault"
  for_each = var.backup_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  storage_accounts    = local.combined_objects_storage_accounts
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, {})
  resource_groups     = local.resource_groups
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
#   resource_group_name = coalesce(
#     try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
#     try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group_key].name, null),
#     try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
#     try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].name, null)
#   )
#   resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
#   base_tags           = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags : {}
}

output "backup_vaults" {
  value = module.backup_vaults
}

module "backup_vault_policies" {
  source = "./modules/backup_vault/backup_vault_policy"
  for_each = try(var.backup_vaults, {})

  settings = each.value
  vault_id = module.backup_vaults[each.key].id
}
locals {
  backup_vault_policies = module.backup_vault_policies
}

output "backup_vault_policies" {
  value = module.backup_vault_policies
}

module "backup_vault_instances" {
  source     = "./modules/backup_vault/backup_vault_instance"
  for_each   = try(var.backup_vault_instances, {}) 
  
  client_config       = local.client_config
  global_settings     = local.global_settings
  settings = each.value
  vault_id = module.backup_vaults[each.value.backup_vault_key].id
  location = lookup(each.value, "region", null) == null ? coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].location, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location, null)
  ) : local.global_settings.regions[each.value.region]  
    }
  storage_account_id = module.storage_accounts[each.value.storage_account_key].id
  backup_policy_id = module.backup_vault_policies[each.value.backup_vault_policy_key].id
}
  
# module "backup_vault_instances" {
#   source     = "./modules/backup_vault/backup_vault_instance"
#   depends_on = [azurerm_role_assignment.for, module.backup_vault_policies]
#   for_each   = try(var.backup_vaults, {})

#   settings = each.value
#   vault_id = module.backup_vaults[each.key].id
#   location = lookup(each.value, "region", null) == null ? coalesce(
#     try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].location, null),
#     try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].location, null)
#   ) : local.global_settings.regions[each.value.region]
#   storage_accounts = module.storage_accounts #Romans item
#   backup_policy    = local.backup_vault_policies[each.key] #Romans item
# }
  
output "backup_vault_instances" {
  value = module.backup_vault_instances
}
