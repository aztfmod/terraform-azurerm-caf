
output "mariadb_servers" {
  value = module.mariadb_servers

}

module "mariadb_servers" {
  source     = "./modules/databases/mariadb_server"
  depends_on = [module.keyvault_access_policies]
  for_each   = local.database.mariadb_servers

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  keyvault_id         = try(each.value.administrator_login_password, null) == null ? module.keyvaults[each.value.keyvault_key].id : null
  storage_accounts    = module.storage_accounts
  vnets               = local.combined_objects_networking
  subnet_id           = can(each.value.subnet_id) || can(each.value.vnet_key) == false ? try(each.value.subnet_id, null) : local.combined_objects_networking[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.vnet_key].subnets[each.value.subnet_key].id

  azuread_groups      = local.combined_objects_azuread_groups
  private_endpoints   = try(each.value.private_endpoints, {})
  resource_groups     = try(each.value.private_endpoints, {}) == {} ? null : local.resource_groups
  private_dns         = local.combined_objects_private_dns
  diagnostic_profiles = try(each.value.diagnostic_profiles, {})
  diagnostics         = local.combined_diagnostics
}