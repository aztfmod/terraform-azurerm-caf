module "monitor_autoscale_settings" {
  depends_on          = [module.virtual_machine_scale_sets, module.app_service_plans]
  source              = "./modules/monitoring/monitor_autoscale_settings"
  for_each            = local.shared_services.monitor_autoscale_settings
  settings            = each.value
  global_settings     = local.global_settings
  client_config       = local.client_config
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    app_service_plans          = local.combined_objects_app_service_plans
    virtual_machine_scale_sets = local.combined_objects_virtual_machine_scale_sets
  }

}
