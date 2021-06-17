module "service_health_alerts" {
  source              = "./modules/monitoring/service_health_alerts"
  for_each            = local.shared_services.monitoring
  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].location : local.global_settings.regions[each.value.region]

}