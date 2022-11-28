module "wvd_applications" {
  source   = "./modules/compute/wvd_applications"
  for_each = local.compute.wvd_applications

  global_settings      = local.global_settings
  settings             = each.value
  application_group_id = can(each.value.application_group_id) ? each.value.application_group_id : local.combined_objects_wvd_application_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.application_group_key].id
  diagnostics          = local.combined_diagnostics
  diagnostic_profiles  = try(each.value.diagnostic_profiles, {})
}

output "wvd_applications" {
  value = module.wvd_applications
}