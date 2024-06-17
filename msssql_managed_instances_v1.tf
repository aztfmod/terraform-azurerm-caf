output "mssql_managed_instances" {
  value = merge(
    module.mssql_managed_instances,
    module.mssql_managed_instances_v1
  )
}
output "mssql_managed_instances_secondary" {
  value = merge(
    module.mssql_managed_instances_secondary,
    module.mssql_managed_instances_secondary_v1
  )
}
output "mssql_mi_failover_groups" {
  value = merge(
    module.mssql_mi_failover_groups,
    module.mssql_mi_failover_groups_v1
  )
}


module "mssql_managed_instances_v1" {
  source = "./modules/databases/mssql_managed_instance_v1"
  for_each = {
    for key, value in local.database.mssql_managed_instances : key => value
    if try(value.version, "") == "v1"
  }
  depends_on = [module.routes, module.azuread_roles_msi]

  global_settings    = local.global_settings
  client_config      = local.client_config
  settings           = each.value
  subnet_id          = can(each.value.networking.subnet_id) ? each.value.networking.subnet_id : local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  managed_identities = local.combined_objects_managed_identities
  keyvault           = can(each.value.administrator_login_password) ? null : local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)]
  primary_server_id  = null
  group_id           = can(each.value.administrators.azuread_group_id) || can(each.value.administrators.azuread_group_key) ? try(each.value.administrators.azuread_group_id, local.combined_objects_azuread_groups[try(each.value.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].id) : null
  vnets              = local.combined_objects_networking
  private_endpoints  = try(each.value.private_endpoints, {})
  private_dns        = local.combined_objects_private_dns
  resource_groups    = local.combined_objects_resource_groups

  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  inherit_tags        = try(local.global_settings.inherit_tags, false)
  resource_group      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? null : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

module "mssql_managed_instances_secondary_v1" {
  source = "./modules/databases/mssql_managed_instance_v1"
  for_each = {
    for key, value in local.database.mssql_managed_instances_secondary : key => value
    if try(value.version, "") == "v1"
  }
  depends_on = [module.routes, module.azuread_roles_msi]

  global_settings    = local.global_settings
  client_config      = local.client_config
  settings           = each.value
  managed_identities = local.combined_objects_managed_identities
  subnet_id          = can(each.value.networking.subnet_id) ? each.value.networking.subnet_id : local.combined_objects_networking[try(each.value.networking.lz_key, local.client_config.landingzone_key)][each.value.networking.vnet_key].subnets[each.value.networking.subnet_key].id
  primary_server_id  = local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.mi_server_key].id
  keyvault           = can(each.value.administrator_login_password) ? null : local.combined_objects_keyvaults[try(each.value.keyvault.lz_key, local.client_config.landingzone_key)][try(each.value.keyvault.key, each.value.keyvault_key)]
  group_id           = can(each.value.administrators.azuread_group_id) || can(each.value.administrators.azuread_group_key) ? try(each.value.administrators.azuread_group_id, local.combined_objects_azuread_groups[try(each.value.administrators.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].id) : null
  vnets              = local.combined_objects_networking
  private_endpoints  = try(each.value.private_endpoints, {})
  private_dns        = local.combined_objects_private_dns
  resource_groups    = local.combined_objects_resource_groups

  base_tags           = try(local.global_settings.inherit_tags, false) ? try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group.key, each.value.resource_group_key)].tags, {}) : {}
  inherit_tags        = try(local.global_settings.inherit_tags, false)
  resource_group      = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? null : local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)]
  resource_group_name = can(each.value.resource_group.name) || can(each.value.resource_group_name) ? try(each.value.resource_group.name, each.value.resource_group_name) : null
  location            = try(local.global_settings.regions[each.value.region], null)
}

module "mssql_mi_failover_groups_v1" {
  source = "./modules/databases/mssql_managed_instance_v1/failover_group"
  for_each = {
    for key, value in local.database.mssql_mi_failover_groups : key => value
    if try(value.version, "") == "v1"
  }
  depends_on               = [module.mssql_managed_instances_secondary_v1]
  global_settings          = local.global_settings
  settings                 = each.value
  managed_instance         = local.combined_objects_mssql_managed_instances[try(each.value.primary_server.lz_key, local.client_config.landingzone_key)][each.value.primary_server.mi_server_key]
  partner_managed_instance = local.combined_objects_mssql_managed_instances_secondary[try(each.value.secondary_server.lz_key, local.client_config.landingzone_key)][each.value.secondary_server.mi_server_key]
}



module "mssql_mi_administrators_v1" {
  source = "./modules/databases/mssql_managed_instance_v1/administrator"

  for_each = {
    for key, value in local.database.mssql_managed_instances : key => value
    if try(value.version, "") == "v1" && try(value.authentication_mode, "aad_only") != "sql_only"
  }

  depends_on = [module.managed_identities]

  managed_instance_id = module.mssql_managed_instances_v1[each.key].id
  settings            = each.value.administrators
  group_id            = can(each.value.administrators.azuread_group_id) ? each.value.administrators.azuread_group_id : local.combined_objects_azuread_groups[try(each.value.administrators.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].id
  tenant_id           = can(each.value.administrators.tenant_id) ? each.value.administrators.tenant_id : local.combined_objects_azuread_groups[try(each.value.administrators.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].tenant_id
  aad_only_auth       = each.value.authentication_mode == "aad_only" ? true : false
}

module "mssql_mi_administrators_secondary_v1" {
  source = "./modules/databases/mssql_managed_instance_v1/administrator"

  for_each = {
    for key, value in local.database.mssql_managed_instances_secondary : key => value
    if try(value.version, "") == "v1" && try(value.authentication_mode, "aad_only") != "sql_only"
  }

  depends_on = [module.managed_identities]

  managed_instance_id = module.mssql_managed_instances_secondary_v1[each.key].id
  settings            = each.value.administrators
  group_id            = can(each.value.administrators.azuread_group_id) ? each.value.administrators.azuread_group_id : local.combined_objects_azuread_groups[try(each.value.administrators.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].id
  tenant_id           = can(each.value.administrators.tenant_id) ? each.value.administrators.tenant_id : local.combined_objects_azuread_groups[try(each.value.administrators.lz_key, local.client_config.landingzone_key)][each.value.administrators.azuread_group_key].tenant_id
  aad_only_auth       = each.value.authentication_mode == "aad_only" ? true : false
}

#Both initial setup and rotation of the TDE protector must be done on the secondary first, and then on primary.
module "mssql_mi_tde_v1" {
  source     = "./modules/databases/mssql_managed_instance_v1/tde"
  depends_on = [module.keyvault_access_policies]

  //depends_on =
  for_each = {
    for key, value in local.database.mssql_mi_tdes : key => value
    if try(value.version, "") == "v1"
  }

  managed_instance_id   = can(each.value.mi_server.id) ? each.value.mi_server.id : local.combined_objects_mssql_managed_instances[try(each.value.mi_server.lz_key, local.client_config.landingzone_key)][each.value.mi_server.key].id
  key_vault_key_id      = can(each.value.keyvault_key) ? try(each.value.keyvault_key.id, local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key.key].id) : null
  auto_rotation_enabled = try(each.value.auto_rotation_enabled, true)
}


module "mssql_mi_secondary_tde_v1" {
  source     = "./modules/databases/mssql_managed_instance_v1/tde"
  depends_on = [module.mssql_mi_tde_v1, module.keyvault_access_policies]

  for_each = {
    for key, value in local.database.mssql_mi_secondary_tdes : key => value
    if try(value.version, "") == "v1"
  }

  managed_instance_id   = can(each.value.mi_server.id) ? each.value.mi_server.id : local.combined_objects_mssql_managed_instances_secondary[try(each.value.mi_server.lz_key, local.client_config.landingzone_key)][each.value.mi_server.key].id
  key_vault_key_id      = can(each.value.keyvault_key) ? try(each.value.keyvault_key.id, local.combined_objects_keyvault_keys[try(each.value.keyvault_key.lz_key, local.client_config.landingzone_key)][each.value.keyvault_key.key].id) : null
  auto_rotation_enabled = try(each.value.auto_rotation_enabled, true)
}
