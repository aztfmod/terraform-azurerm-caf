module "cdn_endpoints" {
  source   = "./modules/networking/cdn_endpoints"
  for_each = local.networking.cdn_endpoints

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    profile_name = can(each.value.profile.name) ? each.value.profile.name : local.combined_objects_cdn_profiles[try(each.value.profile.lz_key, local.client_config.landingzone_key)][each.value.profile.key].name
  }
}

output "cdn_endpoints" {
  value = module.cdn_endpoints
}

module "cdn_profiles" {
  source   = "./modules/networking/cdn_profiles"
  for_each = local.networking.cdn_profiles

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    diagnostics = local.combined_diagnostics
  }
}
output "cdn_profiles" {
  value = module.cdn_profiles
}

moved {
  from = module.cdn_endpoint
  to   = module.cdn_endpoints
}
moved {
  from = module.cdn_profile
  to   = module.cdn_profiles
}
