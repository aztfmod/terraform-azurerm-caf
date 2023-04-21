
module "private_dns_resolver_inbound_endpoints" {
  source   = "./modules/networking/private_dns_resolvers_inbound_endpoints"
  for_each = local.networking.private_dns_resolver_inbound_endpoints

  global_settings         = local.global_settings
  client_config           = local.client_config
  settings                = each.value
  private_dns_resolver_id = can(each.value.private_dns_resolver_id) ? each.value.private_dns_resolver_id : local.combined_objects_private_dns_resolvers[try(each.value.private_dns_resolver.lz_key, local.client_config.landingzone_key)][each.value.private_dns_resolver.key].id
  inherit_tags            = local.global_settings.inherit_tags
  location                = try(local.global_settings.regions[each.value.region], each.value.region)

  subnet_ids = compact(concat(
   [
      for key,value in each.value.ip_configurations :
      can(value.subnet_id) || can(value.vnet.key) == false ? try(value.subnet_id, null) : try(local.combined_objects_networking[try(value.vnet.lz_key, local.client_config.landingzone_key)][value.vnet.key].subnets[value.vnet.subnet_key].id, "")
    ],
    [
      for key,value in each.value.ip_configurations :
      can(value.subnet_id) || can(value.vnet.key) == false ? try(value.subnet_id, null) : try(local.combined_objects_virtual_subnets[try(value.vnet.lz_key, local.client_config.landingzone_key)][value.vnet.subnet_key].id, "")
    ]
  ))
  
}

output "private_dns_resolver_inbound_endpoints" {
  value = module.private_dns_resolver_inbound_endpoints
}
