module "monitor_action_groups" {
  source              = "./modules/monitoring/monitor_action_group"
  for_each            = local.shared_services.monitor_action_groups
  global_settings     = local.global_settings
  resource_group_name = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].name
  settings            = each.value

  remote_objects = {
    event_hub_namespaces = local.combined_objects_event_hub_namespaces
  }
}

output "monitor_action_groups" {
  value = module.monitor_action_groups
}