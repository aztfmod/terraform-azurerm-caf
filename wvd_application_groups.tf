module "wvd_application_groups" {
  source   = "./modules/compute/wvd_application_group"
  for_each = local.compute.wvd_application_groups

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  host_pool_id        = try(local.combined_objects_wvd_host_pools[local.client_config.landingzone_key][each.value.host_pool_key].id, local.combined_objects_wvd_host_pools[each.value.lz_key][each.value.host_pool_key].id)
  workspace_id        = try(local.combined_objects_wvd_workspaces[local.client_config.landingzone_key][each.value.wvd_workspace_key].id, local.combined_objects_wvd_workspaces[each.value.lz_key][each.value.wvd_workspace_key].id)
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
}

output "wvd_application_groups" {
  value = module.wvd_application_groups
}