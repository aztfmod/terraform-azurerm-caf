module "wvd_workspaces" {
  source   = "./modules/compute/wvd_workspace"
  for_each = local.compute.wvd_workspaces

  global_settings     = local.global_settings
  settings            = each.value
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags           = local.global_settings.inherit_tags
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
}

output "wvd_workspaces" {
  value = module.wvd_workspaces
}