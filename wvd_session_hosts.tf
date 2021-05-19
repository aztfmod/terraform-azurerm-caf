module "wvd_session_hosts" {
  depends_on = [module.wvd_host_pools]

  source   = "./modules/compute/wvd_session_host"
  for_each = local.compute.wvd_session_hosts

  global_settings     = local.global_settings
  settings            = each.value
  client_config       = local.client_config
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  host_pool_name      = try(each.value.keyvault_key, null) == null ? null : try(local.combined_objects_wvd_host_pools[local.client_config.landingzone_key][each.value.wvd_host_pool_key].name, local.combined_objects_wvd_host_pools[each.value.lz_key][each.value.wvd_host_pool_key].name)
  wvd_host_pools      = local.combined_objects_wvd_host_pools  
  keyvaults           = local.combined_objects_keyvaults
  vnets               = local.combined_objects_networking
  
}

output "wvd_session_hosts" {
  value = module.wvd_session_hosts
}