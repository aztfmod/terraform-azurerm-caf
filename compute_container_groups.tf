module "container_groups" {
  source     = "./modules/compute/container_group"
  for_each   = local.compute.container_groups
  depends_on = [module.dynamic_keyvault_secrets]


  location                 = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags                = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  client_config            = local.client_config
  combined_diagnostics     = local.combined_diagnostics
  diagnostic_profiles      = try(each.value.diagnostic_profiles, {})
  global_settings          = local.global_settings
  settings                 = each.value
  dynamic_keyvault_secrets = try(local.security.dynamic_keyvault_secrets, {})

  combined_resources = {
    keyvaults          = local.combined_objects_keyvaults
    managed_identities = local.combined_objects_managed_identities
    networking      = local.combined_objects_networking
    virtual_subnets = local.combined_objects_virtual_subnets
  }

}

output "container_groups" {
  value = module.container_groups
}

