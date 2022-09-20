module "monitor_action_groups" {
  source              = "./modules/monitoring/monitor_action_group"
  for_each            = local.shared_services.monitor_action_groups
  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = {
    event_hub_namespaces = local.combined_objects_event_hub_namespaces
  }
}

output "monitor_action_groups" {
  value = module.monitor_action_groups
}