


module "mssql_managed_instances" {
  source = "./modules/databases/mssql_managed_instance"
  for_each = {
    for key, value in local.database.mssql_managed_instances : key => value
    if can(value.version) == false
  }
  depends_on = [module.routes]

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  subnet_id           = can(each.value.networking.subnet_id) ? each.value.networking.subnet_id : local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  inherit_tags        = try(local.global_settings.inherit_tags, false)
  keyvault            = can(each.value.administrator_login_password) ? null : local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)]
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns         = local.combined_objects_private_dns
  resource_groups     = local.combined_objects_resource_groups
}

module "mssql_managed_instances_secondary" {
  source = "./modules/databases/mssql_managed_instance"
  for_each = {
    for key, value in local.database.mssql_managed_instances_secondary : key => value
    if can(value.version) == false
  }
  depends_on = [module.routes]

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  location            = can(local.global_settings.regions[each.value.region]) ? local.global_settings.regions[each.value.region] : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].location
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  inherit_tags        = try(local.global_settings.inherit_tags, false)
  subnet_id           = can(each.value.networking.subnet_id) ? each.value.networking.subnet_id : local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  primary_server_id   = local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.mi_server_key].id
  keyvault            = can(each.value.administrator_login_password) ? null : local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)]
  vnets               = local.combined_objects_networking
  private_endpoints   = try(each.value.private_endpoints, {})
  private_dns         = local.combined_objects_private_dns
  resource_groups     = local.combined_objects_resource_groups
}

module "mssql_mi_failover_groups" {
  source = "./modules/databases/mssql_managed_instance/failover_group"
  for_each = {
    for key, value in local.database.mssql_mi_failover_groups : key => value
    if can(value.version) == false
  }
  global_settings     = local.global_settings
  settings            = each.value
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  primaryManagedInstanceId = local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.mi_server_key].id
  partnerManagedInstanceId = module.mssql_managed_instances_secondary[each.value.secondary_server.mi_server_key].id
  partnerRegion            = module.mssql_managed_instances_secondary[each.value.secondary_server.mi_server_key].location
}

module "mssql_mi_administrators" {
  source = "./modules/databases/mssql_managed_instance/administrator"

  depends_on = [module.azuread_roles_sql_mi, module.azuread_roles_sql_mi_secondary]

  for_each = {
    for key, value in local.database.mssql_mi_administrators : key => value
    if can(value.version) == false
  }
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  mi_name             = try(module.mssql_managed_instances[each.value.mi_server_key].name, module.mssql_managed_instances_secondary[each.value.mi_server_key].name)
  settings            = each.value
  user_principal_name = try(each.value.user_principal_name, null)
  group_id            = try(each.value.azuread_group_id, local.combined_objects_azuread_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.azuread_group_key].id, null)
  group_name          = try(local.combined_objects_azuread_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.azuread_group_key].display_name, null)
}

module "mssql_mi_secondary_tde" {
  source = "./modules/databases/mssql_managed_instance/tde"

  for_each = {
    for key, value in local.database.mssql_mi_secondary_tdes : key => value
    if can(value.version) == false
  }

  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  mi_name            = module.mssql_managed_instances_secondary[each.value.mi_server_key].name
  keyvault_key       = try(local.combined_objects_keyvault_keys[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key_key], null)
  is_secondary_tde   = true
  secondary_keyvault = try(local.combined_objects_keyvaults[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.secondary_keyvault_key], null)
}

#Both initial setup and rotation of the TDE protector must be done on the secondary first, and then on primary.
module "mssql_mi_tde" {
  source     = "./modules/databases/mssql_managed_instance/tde"
  depends_on = [module.mssql_mi_secondary_tde]

  for_each = {
    for key, value in local.database.mssql_mi_tdes : key => value
    if can(value.version) == false
  }


  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name

  mi_name      = module.mssql_managed_instances[each.value.mi_server_key].name
  keyvault_key = try(local.combined_objects_keyvault_keys[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key_key], null)
}