module "container_app_environments" {
  source   = "./modules/compute/container_app_environment"
  for_each = local.compute.container_app_environments

  location             = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group       = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name  = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags            = local.global_settings.inherit_tags
  subnet_id            = can(each.value.subnet_id) ? each.value.subnet_id : try(local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.vnet_key].subnets[each.value.vnet.subnet_key].id, null)
  client_config        = local.client_config
  combined_diagnostics = local.combined_diagnostics
  diagnostic_profiles  = try(each.value.diagnostic_profiles, {})
  diagnostics          = local.combined_diagnostics
  global_settings      = local.global_settings
  settings             = each.value
}

output "container_app_environments" {
  value = module.container_app_environments
}

