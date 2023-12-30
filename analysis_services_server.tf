module "analysis_services_server" {
  source   = "./modules/analytics/analysis_services_server"
  for_each = local.database.analysis_services_server

  base_tags           = local.global_settings.inherit_tags
  client_config       = local.client_config
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  resource_groups     = local.combined_objects_resource_groups
  settings            = each.value
  vnets               = local.combined_objects_networking
}

output "analysis_services_server" {
  value = module.analysis_services_server
}
