
module "private_dns_resolver_outbound_endpoints" {
  source   = "./modules/networking/private_dns_resolvers_outbound_endpoints"
  for_each = local.networking.private_dns_resolver_outbound_endpoints

  global_settings         = local.global_settings
  client_config           = local.client_config
  settings                = each.value
  private_dns_resolver_id = can(each.value.private_dns_resolver_id) || can(each.value.private_dns_resolver.id) ? try(each.value.private_dns_resolver_id, each.value.private_dns_resolver.id) : local.combined_objects_private_dns_resolvers[try(each.value.private_dns_resolver.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolver.key].id
  inherit_tags            = local.global_settings.inherit_tags
  location                = can(each.value.private_dns_resolver_id) || can(each.value.private_dns_resolver.id) || can(each.value.region) ? local.global_settings.regions[each.value.region] : local.combined_objects_private_dns_resolvers[try(each.value.private_dns_resolver.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolver.key].location
  tags                    = can(each.value.private_dns_resolver_id) || can(each.value.private_dns_resolver.id) || local.global_settings.inherit_tags == false ? null : try(local.combined_objects_private_dns_resolvers[try(each.value.private_dns_resolver.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolver.key].tags, {})

  subnet_id = can(each.value.subnet_id) || can(each.value.vnet.key) == false ? try(each.value.subnet_id, local.combined_objects_virtual_subnets[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.subnet_key].id) : local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id

}

output "private_dns_resolver_outbound_endpoints" {
  value = module.private_dns_resolver_outbound_endpoints
}
