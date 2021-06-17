
module "log_analytics" {
  source   = "./modules/log_analytics"
  for_each = var.log_analytics

  global_settings = local.global_settings
  log_analytics   = each.value
  resource_groups = local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)]
  base_tags       = try(local.global_settings.inherit_tags, false) ? local.combined_objects_resource_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.resource_group_key].tags : {}
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

