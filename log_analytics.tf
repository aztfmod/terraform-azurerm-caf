
module "log_analytics" {
  source   = "./modules/log_analytics"
  for_each = var.log_analytics

  global_settings = local.global_settings
  log_analytics   = each.value
  resource_groups = local.resource_groups
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
}

module "log_analytics_diagnostics" {
  source   = "./modules/diagnostics"
  for_each = var.log_analytics

  resource_id       = module.log_analytics[each.key].id
  resource_location = module.log_analytics[each.key].location
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}

output "log_analytics" {
  value = module.log_analytics
}

module "log_analytics_storage_insights" {
  source   = "./modules/monitoring/log_analytics_storage_insights"
  for_each = local.shared_services.log_analytics_storage_insights

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  workspace_id = coalesce(
    try(local.combined_objects_log_analytics[each.value.log_analytics.lz_key][each.value.log_analytics.key].id, null),
    try(local.combined_objects_log_analytics[local.client_config.landingzone_key][each.value.log_analytics.key].id, null),
    try(each.value.log_analytics.workspace_id, null)
  )
  storage_account_id = coalesce(
    try(local.combined_objects_storage_accounts[each.value.storage_account.lz_key][each.value.storage_account.key].id, null),
    try(local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_account.key].id, null),
    try(each.value.storage_account.id, null)
  )
  primary_access_key = coalesce(
    try(local.combined_objects_storage_accounts[each.value.storage_account.lz_key][each.value.storage_account.key].primary_access_key, null),
    try(local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_account.key].primary_access_key, null),
    try(each.value.storage_account.primary_access_key, null)
  )


  remote_objects = {
    resource_group  = local.combined_objects_resource_groups
    storage_account = local.combined_objects_storage_accounts
    log_analytics   = local.combined_objects_log_analytics
  }
}
output "log_analytics_storage_insights" {
  value = module.log_analytics_storage_insights
}