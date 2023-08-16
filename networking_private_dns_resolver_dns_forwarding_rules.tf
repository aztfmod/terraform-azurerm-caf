
module "private_dns_resolver_forwarding_rules" {
  source   = "./modules/networking/private_dns_resolvers_forwarding_rules"
  for_each = local.networking.private_dns_resolver_forwarding_rules

  global_settings           = local.global_settings
  client_config             = local.client_config
  settings                  = each.value
  dns_forwarding_ruleset_id = can(each.value.dns_forwarding_ruleset.id) ? each.value.dns_forwarding_ruleset.id : local.combined_objects_private_dns_resolver_dns_forwarding_rulesets[try(each.value.dns_forwarding_ruleset.lz_key, local.client_config.landingzone_key)][each.value.dns_forwarding_ruleset.key].id

}

output "private_dns_resolver_forwarding_rules" {
  value = module.private_dns_resolver_forwarding_rules
}
