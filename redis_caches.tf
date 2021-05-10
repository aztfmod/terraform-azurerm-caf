
module "redis_caches" {
  source     = "./modules/redis_cache"
  depends_on = [module.networking]
  for_each   = local.database.azurerm_redis_caches

  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  diagnostic_profiles = try(each.value.diagnostic_profiles, null)
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  redis               = each.value.redis
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  subnet_id           = try(local.combined_objects_networking[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id, null)
  tags                = try(each.value.tags, null)

}

output "redis_caches" {
  value = module.redis_caches
}
