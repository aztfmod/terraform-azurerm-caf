
module "recovery_vaults" {
  source   = "./modules/recovery_vault"
  for_each = local.shared_services.recovery_vaults

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  identity            = try(each.value.identity, null)
  resource_groups     = local.resource_groups
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  vnets               = try(local.combined_objects_networking, {})
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns         = local.combined_objects_private_dns

}

output "recovery_vaults" {
  value = module.recovery_vaults

}
