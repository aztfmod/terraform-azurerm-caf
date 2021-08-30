module "redis_caches" {
  source   = "../private_endpoint"
  for_each = try(var.private_endpoints.redis_caches, {})

  global_settings     = var.global_settings
  client_config       = var.client_config
  settings            = each.value
  resource_id         = try(var.remote_objects.redis_caches[each.value.lz_key][each.key].redis_cache.id, var.remote_objects.redis_caches[var.client_config.landingzone_key][each.key].redis_cache.id)
  subresource_names   = ["redisCache"]
  subnet_id           = var.subnet_id
  private_dns         = var.private_dns
  name                = try(each.value.name, each.key)
  resource_group_name = try(var.resource_groups[each.value.resource_group_key].name, var.vnet_resource_group_name)
  location            = var.vnet_location # The private endpoint must be deployed in the same region as the virtual network.
  base_tags           = var.base_tags
}
