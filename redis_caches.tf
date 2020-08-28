
module "redis_caches" {
  source = "./modules/terraform-azurerm-caf-redis-cache"

  for_each = local.database.azurerm_redis_caches

  tags                = try(each.value.tags, null)
  location            = lookup(each.value, "region", null) == null ? azurerm_resource_group.rg[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  resource_group_name = azurerm_resource_group.rg[each.value.resource_group_key].name
  redis               = each.value.redis
  global_settings     = local.global_settings
}

output "redis_caches" {
  value = module.redis_caches
}