module "service_health_alerts" {
  source              = "./modules/monitoring/service_health_alerts"
  for_each            = local.shared_services.monitoring
  global_settings     = local.global_settings
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

}

module "monitor_metric_alert" {
  source   = "./modules/monitoring/monitor_metric_alert"
  for_each = local.shared_services.monitor_metric_alert

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = local.remote_objects
}
output "monitor_metric_alert" {
  value = module.monitor_metric_alert
}

module "monitor_activity_log_alert" {
  source   = "./modules/monitoring/monitor_activity_log_alert"
  for_each = local.shared_services.monitor_activity_log_alert

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  remote_objects = local.remote_objects
}
output "monitor_activity_log_alert" {
  value = module.monitor_activity_log_alert
}

module "monitor_private_link_scope" {
  source   = "./modules/monitoring/monitor_private_link_scope"
  for_each = local.shared_services.monitor_private_link_scope

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  linked_resource_id  = each.value.linked_resource_id 
  remote_objects      = local.remote_objects
  vnets               = local.combined_objects_networking
  virtual_subnets     = local.combined_objects_virtual_subnets
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = local.combined_objects_resource_groups
  private_dns         = local.combined_objects_private_dns
}
output "monitor_private_link_scope" {
  value = module.monitor_private_link_scope
}