module "communication_services" {
  source   = "./modules/communication/communication_services"
  for_each = try(local.communication.communication_services, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}

output "communication_services" {
  value = module.communication_services

}

module "communication_services_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = local.communication.communication_services

  resource_id       = module.communication_services[each.key].id
  resource_location = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}