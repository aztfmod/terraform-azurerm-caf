module "wvd_scaling_plans" {
  source   = "./modules/compute/wvd_scaling_plan"
  for_each = local.compute.wvd_scaling_plans

  global_settings     = local.global_settings
  settings            = each.value
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "wvd_scaling_plans" {
  value = module.wvd_scaling_plans
}

module "wvd_host_pool" {
  source = "./modules/compute/wvd_host_pool"
}

locals {
  wvd_host_pools = module.wvd_host_pool.wvd_host_pools
}

