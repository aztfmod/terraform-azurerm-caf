
module recovery_vaults {
  source   = "./modules/recovery_vault"
  for_each = local.shared_services.recovery_vaults

  global_settings     = local.global_settings
  settings            = each.value
  diagnostics         = local.diagnostics
  identity            = try(each.value.identity, null)
  resource_groups     = module.resource_groups
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : var.global_settings.regions[each.value.region]
  vnets               = try(local.combined_objects_networking, {})
  subnet_id           = try(each.value.vnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)
  private_endpoints   = try(each.value.private_endpoints, {})
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

output recovery_vaults {
  value     = module.recovery_vaults
  sensitive = false
}
