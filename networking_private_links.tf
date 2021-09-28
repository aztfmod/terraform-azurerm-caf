module "private_endpoints" {
  source   = "./modules/networking/private_links/endpoints"
  for_each = try(var.networking.private_endpoints, {})

  global_settings   = local.global_settings
  client_config     = local.client_config
  resource_groups   = local.resource_groups
  settings          = each.value
  private_endpoints = var.networking.private_endpoints
  private_dns       = local.combined_objects_private_dns
  vnet              = try(local.combined_objects_networking[each.value.lz_key][each.value.vnet_key], local.combined_objects_networking[local.client_config.landingzone_key][each.value.vnet_key])
  #base_tags         = try(local.global_settings.inherit_tags, false) ? local.resource_groups[each.value.resource_group_key].tags : {}
  base_tags = try(local.global_settings.inherit_tags, false) ? coalesce(
    try(local.resource_groups[each.value.resource_group_key].tags, null),
    try(local.resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[each.value.lz_key][each.value.resource_group_key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].tags, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group_key].tags, null)
  ) : {}

  remote_objects = {
    diagnostic_storage_accounts     = local.combined_diagnostics.storage_accounts
    diagnostic_event_hub_namespaces = local.combined_diagnostics.event_hub_namespaces

    event_hub_namespaces = local.combined_objects_event_hub_namespaces
    keyvaults            = local.combined_objects_keyvaults
    mysql_servers        = local.combined_objects_mysql_servers
    mssql_servers        = local.combined_objects_mssql_servers
    redis_caches         = local.combined_objects_redis_caches
    networking           = local.combined_objects_networking
    recovery_vaults      = local.combined_objects_recovery_vaults
    storage_accounts     = local.combined_objects_storage_accounts
  }

}
