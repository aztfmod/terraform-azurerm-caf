
module "redis_caches" {
  source   = "./modules/redis_cache"
  for_each = local.database.azurerm_redis_caches

  tags                = try(each.value.tags, null)
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  redis               = each.value.redis
  global_settings     = local.global_settings
  base_tags           = try(local.global_settings.inherit_tags, false) ? module.resource_groups[each.value.resource_group_key].tags : {}

}

output "redis_caches" {
  value = module.redis_caches
}