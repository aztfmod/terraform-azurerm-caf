module "wvd_application_groups" {
  source   = "./modules/compute/wvd_application_group"
  for_each = local.compute.wvd_application_groups

  global_settings     = local.global_settings
  settings            = each.value
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags           = local.global_settings.inherit_tags
  host_pool_id        = can(each.value.host_pool_id) ? each.value.host_pool_id : local.combined_objects_wvd_host_pools[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.host_pool_key].id
  workspace_id        = can(each.value.workspace_id) ? each.value.workspace_id : local.combined_objects_wvd_workspaces[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.wvd_workspace_key].id
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
}

output "wvd_application_groups" {
  value = module.wvd_application_groups
}