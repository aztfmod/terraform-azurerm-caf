
module "private_dns_resolver_inbound_endpoints" {
  source   = "./modules/networking/private_dns_resolver_inbound_endpoints"
  for_each = local.networking.private_dns_resolver_inbound_endpoints

  global_settings         = local.global_settings
  client_config           = local.client_config
  settings                = each.value
  private_dns_resolver_id = can(each.value.private_dns_resolver_id) ? each.value.private_dns_resolver_id : local.combined_objects_networking[try(each.value.private_dns_resolver.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolver.key].id
  inherit_tags            = local.global_settings.inherit_tags
  subnet_id               = can(each.value.subnet_id) || can(each.value.vnet.key) == false ? try(each.value.subnet_id, null) : local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].subnets[each.value.subnet_key].id
  location                = try(local.global_settings.regions[each.value.region], each.value.region)
}

output "private_dns_resolver_inbound_endpoints" {
  value = module.private_dns_resolver_inbound_endpoints
}
