module "wvd_session_hosts" {
  source   = "./modules/compute/wvd_session_host"
  for_each = local.compute.wvd_session_hosts

  global_settings     = local.global_settings
  settings            = each.value
  client_config       = local.client_config
  resource_group_name = module.resource_groups[each.value.resource_group_key].name  
  # vnet_name           = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].name, var.vnets[each.value.lz_key][each.value.vnet_key].name)
  # vnets               = local.combined_objects_networking
  # subnet_id           = local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  # subnet_id           = try(var.vnets[var.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, var.vnets[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  # hostpool_resource_group =  module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  host_pool_name      = module.wvd_host_pools[each.value.wvd_host_pool_key].name
  # host_pool_token     = try(local.combined_objects_wvd_host_pools[local.client_config.landingzone_key][each.value.host_pool_key].id, local.combined_objects_wvd_host_pools[each.value.lz_key][each.value.host_pool_key].registration_info[0].token)
  # key_vaults          =  local.combined_objects_keyvaults
  key_vault_id        = try(each.value.keyvault_key, null) == null ? null : try(local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id)
  # key_vault_id         = try(local.combined_objects_keyvaults[each.value.lz_key][each.value.keyvault_key].id, local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault_key].id)
}