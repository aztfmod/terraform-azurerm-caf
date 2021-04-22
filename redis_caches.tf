
module "redis_caches" {
  source     = "./modules/redis_cache"
  depends_on = [module.networking]
  for_each   = local.database.azurerm_redis_caches

  tags                = try(each.value.tags, null)
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  redis               = each.value.redis
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}
  subnet_id           = try(each.value.subnet_key, null) == null ? null : try(local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].subnets[each.value.subnet_key].id, local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].subnets[each.value.subnet_key].id)

}

output "redis_caches" {
  value = module.redis_caches
}
