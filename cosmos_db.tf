module "cosmos_dbs" {
  source   = "./modules/databases/cosmos_dbs"
  for_each = local.database.cosmos_dbs

  global_settings    = local.global_settings
  client_config      = local.client_config
  private_endpoints  = try(each.value.private_endpoints, {})
  resource_groups    = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  vnets              = local.combined_objects_networking
  settings           = each.value
  private_dns        = local.combined_objects_private_dns
  managed_identities = local.combined_objects_managed_identities

  base_tags           = local.global_settings.inherit_tags
  resource_group      = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

output "cosmos_dbs" {
  value = module.cosmos_dbs
}
