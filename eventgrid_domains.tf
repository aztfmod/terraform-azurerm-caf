module "eventgrid_domains" {
  source      = "./modules/messaging/eventgrid_domains"
  for_each = try(local.messaging.eventgrid_domains, {})

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  // resource_group_name = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)]
  base_tags           = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  // resource_groups    = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)]
  // diagnostics        = local.combined_diagnostics
  vnets              = local.combined_objects_networking
  private_dns        = local.combined_objects_private_dns
}

output "eventgrid_domains" {
  value = module.eventgrid_domains
}

module "eventgrid_domains_diagnostics" {
  source   = "./modules/diagnostics"
  // for_each = var.eventgrid_domains
  for_each = local.messaging.eventgrid_domains

  resource_id       = module.eventgrid_domains[each.key].id
  // resource_location = module.eventgrid_domains[each.key].location
  resource_location = lookup(each.value, "region", null) == null ? local.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  diagnostics       = local.combined_diagnostics
  profiles          = try(each.value.diagnostic_profiles, {})
}