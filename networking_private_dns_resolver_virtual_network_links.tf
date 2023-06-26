
module "private_dns_resolvers_virtual_network_links" {
  source   = "./modules/networking/private_dns_resolvers_virtual_network_links"
  for_each = local.networking.private_dns_resolver_virtual_network_links

  global_settings           = local.global_settings
  client_config             = local.client_config
  settings                  = each.value
  dns_forwarding_ruleset_id = can(each.value.dns_forwarding_ruleset.id) ? each.value.dns_forwarding_ruleset.id : local.combined_objects_private_dns_resolver_dns_forwarding_rulesets[try(each.value.dns_forwarding_ruleset.lz_key, local.client_config.landingzone_key)][each.value.dns_forwarding_ruleset.key].id
  virtual_networks          = local.combined_objects_networking
}

output "private_dns_resolvers_virtual_network_links" {
  value = module.private_dns_resolvers_virtual_network_links
}
