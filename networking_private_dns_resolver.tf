module "private_dns_resolvers" {
  source   = "./modules/networking/private_dns_resolvers"
  for_each = local.networking.private_dns_resolvers

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  virtual_network_id  = try(local.combined_objects_networking[each.value.lz_key][each.value.vnet_key].id, local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key].id)
  resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].name
  location            = lookup(each.value, "region", null) == null ? local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location : local.global_settings.regions[each.value.region]
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
}