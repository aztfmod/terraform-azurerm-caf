
module "private_dns_resolvers_virtual_network_link" {
  source   = "./modules/networking/private_dns_resolvers_virtual_network_link"
  for_each = local.networking.private_dns_resolver_virtual_network_links

  global_settings           = local.global_settings
  client_config             = local.client_config
  settings                  = each.value
  dns_forwarding_ruleset_id = can(each.value.dns_forwarding_ruleset.id) ? try(each.value.dns_forwarding_ruleset.id, null) : local.combined_objects_private_dns_resolver_dns_forwarding_ruleset[try(each.value.dns_forwarding_ruleset.lz_key, local.client_config.landingzone_key)][each.value.dns_forwarding_ruleset.key].id
  inherit_tags              = local.global_settings.inherit_tags
  location                  = try(local.global_settings.regions[each.value.region], each.value.region)
  virtual_network_id        = can(each.value.vent.id) ? try(each.value.vent.id, null) : local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].id

}

output "private_dns_resolvers_virtual_network_link" {
  value = module.private_dns_resolvers_virtual_network_link
}
