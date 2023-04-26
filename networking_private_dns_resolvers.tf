
module "private_dns_resolvers" {
  source   = "./modules/networking/private-dns-resolvers"
  for_each = local.networking.private_dns_resolvers

  global_settings    = local.global_settings
  client_config      = local.client_config
  settings           = each.value
  virtual_network_id = can(each.value.vnet.id) ? each.value.vnet.id : local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].id
  inherit_tags       = local.global_settings.inherit_tags
  resource_group     = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  location           = try(local.global_settings.regions[each.value.region], null)
}

output "private_dns_resolvers" {
  value = module.private_dns_resolvers
}
