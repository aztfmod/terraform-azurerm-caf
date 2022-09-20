module "traffic_manager_profile" {
  source   = "./modules/networking/traffic_manager/traffic_manager_profile"
  for_each = local.networking.traffic_manager_profile

  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

output "traffic_manager_profile" {
  value = module.traffic_manager_profile
}

module "traffic_manager_external_endpoint" {
  depends_on = [module.traffic_manager_profile]
  source     = "./modules/networking/traffic_manager/traffic_manager_external_endpoint"
  for_each   = local.networking.traffic_manager_external_endpoint

  settings   = each.value
  profile_id = local.combined_objects_traffic_manager_profile[try(each.value.traffic_manager_profile.lz_key, local.client_config.landingzone_key)][each.value.traffic_manager_profile.key].id
}
output "traffic_manager_external_endpoint" {
  value = module.traffic_manager_external_endpoint
}

module "traffic_manager_nested_endpoint" {
  depends_on         = [module.traffic_manager_profile]
  source             = "./modules/networking/traffic_manager/traffic_manager_nested_endpoint"
  for_each           = local.networking.traffic_manager_nested_endpoint
  settings           = each.value
  target_resource_id = local.combined_objects_traffic_manager_profile[try(each.value.target_traffic_manager_profile.lz_key, local.client_config.landingzone_key)][each.value.target_traffic_manager_profile.key].id
  profile_id         = local.combined_objects_traffic_manager_profile[try(each.value.traffic_manager_profile.lz_key, local.client_config.landingzone_key)][each.value.traffic_manager_profile.key].id
}

output "traffic_manager_nested_endpoint" {
  value = module.traffic_manager_nested_endpoint
}

module "traffic_manager_azure_endpoint" {
  depends_on = [module.traffic_manager_profile]
  source     = "./modules/networking/traffic_manager/traffic_manager_azure_endpoint"
  for_each   = local.networking.traffic_manager_azure_endpoint
  settings   = each.value
  profile_id = local.combined_objects_traffic_manager_profile[try(each.value.traffic_manager_profile.lz_key, local.client_config.landingzone_key)][each.value.traffic_manager_profile.key].id

  remote_objects = {
    public_ip_addresses = try(local.combined_objects_public_ip_addresses[try(each.value.public_ip_addresses.lz_key, local.client_config.landingzone_key)][each.value.public_ip_address.key].id, null)
    app_services        = try(local.combined_objects_app_services[try(each.value.app_services.lz_key, local.client_config.landingzone_key)][each.value.app_services.key].id, null)
    app_services_slot   = try(local.combined_objects_app_services[try(each.value.app_services.lz_key, local.client_config.landingzone_key)][each.value.app_services.key].slot[each.value.app_services.slot_key].id, null)
  }
}

output "traffic_manager_azure_endpoint" {
  value = module.traffic_manager_azure_endpoint
}
