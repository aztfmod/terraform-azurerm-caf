module container_registry {
  source   = "./modules/compute/container_registry"
  for_each = try(local.compute.azure_container_registries, {})

  global_settings          = local.global_settings
  name                     = each.value.name
  resource_group_name      = azurerm_resource_group.rg[each.value.resource_group_key].name
  location                 = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  admin_enabled            = try(each.value.admin_enabled, false)
  sku                      = try(each.value.sku, "Basic")
  tags                     = try(each.value.tags, {})
  network_rule_set         = try(each.value.network_rule_set, {})
  vnets                    = module.networking
  georeplication_locations = try([for region in try(each.value.georeplication_region_keys, []) : var.global_settings.regions[region]], null)
  diagnostics              = local.diagnostics
  diagnostic_profiles      = try(each.value.diagnostic_profiles, {})
  private_endpoints        = try(each.value.private_endpoints, {})
  resource_groups          = azurerm_resource_group.rg
  tfstates                 = var.tfstates
  use_msi                  = var.use_msi
}

