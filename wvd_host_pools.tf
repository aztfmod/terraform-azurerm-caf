module "wvd_host_pools" {
  source   = "./modules/compute/wvd_host_pool"
  for_each = local.compute.wvd_host_pools

  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  diagnostics         = local.combined_diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
}

output "wvd_host_pools" {
  value     = module.wvd_host_pools
  sensitive = true
}