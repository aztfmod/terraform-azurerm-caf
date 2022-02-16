module "service_health_alerts" {
  source              = "./modules/monitoring/service_health_alerts"
  for_each            = local.shared_services.monitoring
  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]

}

module "monitor_metric_alert" {
  source   = "./modules/monitoring/monitor_metric_alert"
  for_each = local.shared_services.monitor_metric_alert

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  remote_objects = local.remote_objects
}
output "monitor_metric_alert" {
  value = module.monitor_metric_alert
}

module "monitor_activity_log_alert" {
  source   = "./modules/monitoring/monitor_activity_log_alert"
  for_each = local.shared_services.monitor_activity_log_alert

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  remote_objects = local.remote_objects
}
output "monitor_activity_log_alert" {
  value = module.monitor_activity_log_alert
}