
output postgresql_servers {
  value     = module.postgresql_servers
  sensitive = true
}

module "postgresql_servers" {
  source     = "./modules/databases/postgresql_server"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.database.postgresql_servers

  global_settings     = local.global_settings
  settings            = each.value
  sku_name            = each.value
  resource_group_name = module.resource_groups[each.value.resource_group_key].name
  location            = lookup(each.value, "region", null) == null ? module.resource_groups[each.value.resource_group_key].location : local.global_settings.regions[each.value.region]
  keyvault_id         = try(each.value.administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
  storage_accounts    = module.storage_accounts
  azuread_groups      = module.azuread_groups
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : module.resource_groups

  ssl_enforcement_enabled                 = try(each.value.ssl_enforcement_enabled, null)
  administrator_login_password            = try(each.value.administrator_login_password, null)
  auto_grow_enabled                       = try(each.value.auto_grow_enabled, null)
  create_mode                             = try(each.value.create_mode, null)
  name                                    = each.value.name
  storage_mb                              = try(each.value.storage_mb, null)
  geo_redundant_backup_enabled            = try(each.value.geo_redundant_backup_enabled, null)
  backup_retention_days                   = try(each.value.backup_retention_days, null)
  infrastructure_encryption_enabled       = try(each.value.infrastructure_encryption_enabled, null)
  creation_source_server_id               = try(each.value.creation_source_server_id, null)
  administrator_login                     = try(each.value.administrator_login, null)
  public_network_access_enabled           = try(each.value.public_network_access_enabled, null)
  ssl_minimal_tls_version_enforced        = try(each.value.ssl_minimal_tls_version_enforced, null)
  restore_point_in_time                   = try(each.value.restore_point_in_time, null)
  tags                                    = try(each.value.tags, null)
  
}