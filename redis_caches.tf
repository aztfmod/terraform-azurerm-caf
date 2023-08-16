
module "redis_caches" {
  source     = "./modules/redis_cache"
  depends_on = [module.networking]
  for_each   = local.database.azurerm_redis_caches

  client_config       = local.client_config
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
  global_settings     = local.global_settings
  redis               = each.value.redis
  subnet_id           = can(each.value.subnet_id) || can(each.value.subnet_key) == false ? try(each.value.subnet_id, null) : local.combined_objects_networking[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id
  tags                = try(each.value.tags, null)
  private_endpoints   = try(each.value.private_endpoints, {})
  vnets               = local.combined_objects_networking
  private_dns         = local.combined_objects_private_dns
  managed_identities  = local.combined_objects_managed_identities

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "redis_caches" {
  value = module.redis_caches
}
