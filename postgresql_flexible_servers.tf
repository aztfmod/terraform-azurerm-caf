output "postgresql_flexible_servers" {
  value = module.postgresql_flexible_servers
}

module "postgresql_flexible_servers" {
  source     = "./modules/databases/postgresql_flexible_server"
  depends_on = [module.keyvaults, module.networking]
  for_each   = local.database.postgresql_flexible_servers

  global_settings   = local.global_settings
  client_config     = local.client_config
  settings          = each.value
  resource_group    = local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)]
  base_tags         = local.global_settings.inherit_tags
  vnets             = local.combined_objects_networking
  private_endpoints = try(each.value.private_endpoints, {})
  private_dns       = local.combined_objects_private_dns

  remote_objects = {
    subnet_id           = can(each.value.vnet.subnet_key) ? local.combined_objects_networking[try(each.value.vnet.lz_key, local.client_config.landingzone_key)][each.value.vnet.key].subnets[each.value.vnet.subnet_key].id : null
    private_dns_zone_id = can(each.value.private_dns_zone.key) ? local.combined_objects_private_dns[try(each.value.private_dns_zone.lz_key, local.client_config.landingzone_key)][each.value.private_dns_zone.key].id : null
    keyvault_id         = can(each.value.keyvault.key) ? local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][each.value.keyvault.key].id : null
    diagnostics         = local.combined_diagnostics
    azuread_groups      = local.combined_objects_azuread_groups
    azuread_users       = local.combined_objects_azuread_users
    service_principals  = local.combined_objects_azuread_service_principals
    managed_identities  = local.combined_objects_managed_identities
  }
}
