
module "log_analytics" {
  source   = "./modules/log_analytics"
  for_each = var.log_analytics

  global_settings     = local.global_settings
  log_analytics       = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
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

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  workspace_id        = can(each.value.log_analytics.workspace_id) ? each.value.log_analytics.workspace_id : local.combined_objects_log_analytics[try(each.value.log_analytics.lz_key, local.client_config.landingzone_key)][each.value.log_analytics.key].id
  storage_account_id  = can(each.value.storage_account.id) ? each.value.storage_account.id : local.combined_objects_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][each.value.storage_account.key].id
  primary_access_key  = can(each.value.storage_account.primary_access_key) ? each.value.storage_account.primary_access_key : local.combined_objects_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][each.value.storage_account.key].primary_access_key

  remote_objects = {
    resource_group  = local.combined_objects_resource_groups
    storage_account = local.combined_objects_storage_accounts
    log_analytics   = local.combined_objects_log_analytics
  }
}
output "log_analytics_storage_insights" {
  value = module.log_analytics_storage_insights
}