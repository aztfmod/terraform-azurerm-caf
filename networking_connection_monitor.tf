

module "network_connection_monitors" {
  source   = "./modules/networking/network_connection_monitor"
  for_each = local.networking.network_connection_monitors

  global_settings = local.global_settings
  client_config   = local.client_config
  location        = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location

  tags = try(each.value.tags, null)

  name                                = each.value.name
  network_watcher_resource_group_name = try(each.value.network_watcher_resource_group_name, null)
  network_watcher_name                = try(each.value.network_watcher_name, null)

  combined_objects_log_analytics = local.combined_objects_log_analytics

  endpoint_objects = {
    virtual_subnets  = local.combined_objects_virtual_subnets
    virtual_machines = local.combined_objects_virtual_machines
    vnets            = local.combined_objects_networking
  }

  settings  = each.value
  base_tags = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}



output "network_connection_monitors" {
  value = module.network_connection_monitors
}
