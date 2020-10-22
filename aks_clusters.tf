output aks_clusters {
  value     = module.aks_clusters
  sensitive = true
}

module aks_clusters {
  source   = "./modules/compute/aks"
  for_each = local.compute.aks_clusters

  global_settings     = local.global_settings
  diagnostics         = local.diagnostics
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  settings            = each.value
  subnets             = lookup(each.value.networking, "lz_key", null) == null ? local.combined_objects_networking[each.value.vnet_key].subnets : local.combined_objects_networking[each.value.lz_key].vnets[each.value.vnet_key].subnets
  resource_group      = module.resource_groups[each.value.resource_group_key]
  admin_group_ids     = try(each.value.admin_groups.azuread_group_keys, null) == null ? each.value.admin_groups.ids : [for group_key in each.value.admin_groups.azuread_group_keys : module.azuread_groups[group_key].id]
}
