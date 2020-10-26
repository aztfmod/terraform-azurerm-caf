module container_registry {
  source   = "./modules/compute/container_registry"
  for_each = local.compute.azure_container_registries

  global_settings          = local.global_settings
  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  location                 = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  admin_enabled            = try(each.value.admin_enabled, false)
  sku                      = try(each.value.sku, "Basic")
  tags                     = try(each.value.tags, {})
  network_rule_set         = try(each.value.network_rule_set, {})
  vnets                    = module.networking
  georeplication_locations = try(each.value.georeplication_region_keys, null) == null ? null : [for region in try(each.value.georeplication_region_keys, []) : var.global_settings.regions[region]]
  diagnostics              = local.diagnostics
  diagnostic_profiles      = try(each.value.diagnostic_profiles, {})
  private_endpoints        = try(each.value.private_endpoints, {})
  resource_groups          = module.resource_groups
  tfstates                 = var.tfstates
  use_msi                  = var.use_msi
  base_tags                = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
}

