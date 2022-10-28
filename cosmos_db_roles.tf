# TODO(pbourke): When referring to Cosmos DB SQL containers or databases in scope arguments, the
# resource id must match the format described at
# https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-setup-rbac#role-definitions. For some
# reason, this is different to what's used in Terraform (and elsewhere in Azure), causing AzureRM to
# error out with 400 BadRequest. Hence the calls to replace() throughout this file.
#
# You may also see a 412 PreconditionFailed error when trying to create multiple assignments at
# once. This should be fixed in https://github.com/hashicorp/terraform-provider-azurerm/pull/15862
# and so needs to be retested once CAF moves to 3.x of the provider:
# https://github.com/aztfmod/terraform-azurerm-caf/pull/1400

module "cosmosdb_custom_roles" {
  source   = "./modules/roles/cosmosdb_custom_roles"
  for_each = local.database.cosmosdb_role_definitions

  global_settings = local.global_settings
  resource_group_name = (
    can(each.value.resource_group.name) || can(each.value.resource_group_name) ?
    try(each.value.resource_group.name, each.value.resource_group_name) :
    local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  )
  account_name = (
    can(each.value.account.name) || can(each.value.account_name) ?
    try(each.value.account.name, each.value.account_name) :
    local.combined_objects_cosmos_dbs[try(each.value.account.lz_key, local.client_config.landingzone_key)][try(each.value.account_key, each.value.account.key)].name
  )
  assignable_scopes  = local.cosmos_db_assignable_scopes[each.key]
  permissions        = each.value.permissions
  name               = each.value.name
  role_definition_id = try(each.value.role_definition_id, null)
  type               = try(each.value.type, null)
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmos_account" {
  for_each = local.cosmosdb_account_roles

  account_name = local.combined_objects_cosmos_dbs[try(each.value.account.lz_key, local.client_config.landingzone_key)][try(each.value.account_key, each.value.account.key)].name
  resource_group_name = (
    try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
    try(each.value.resource_group.name, each.value.resource_group_name) :
    local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  )
  principal_id = (
    each.value.object_id_resource_type == "object_ids" ?
    each.value.object_id_key_resource :
    each.value.object_id_lz_key == null ?
    local.services_roles[each.value.object_id_resource_type][var.current_landingzone_key][each.value.object_id_key_resource].rbac_id :
    local.services_roles[each.value.object_id_resource_type][each.value.object_id_lz_key][each.value.object_id_key_resource].rbac_id
  )
  role_definition_id = (
    each.value.mode == "custom_role_mapping" ?
    module.cosmosdb_custom_roles[each.value.role_definition_name].id :
    format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.DocumentDB/databaseAccounts/%s/sqlRoleDefinitions/%s",
      local.client_config.subscription_id,
      (
        try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
        try(each.value.resource_group.name, each.value.resource_group_name) :
        local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
      ),
      local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name,
      local.cosmosdb_built_in_roles[lower(each.value.role_definition_name)]
    )
  )
  scope = (
    each.value.account_lz_key == null ?
    local.combined_objects_cosmos_dbs[var.current_landingzone_key][each.value.account_key].id :
    local.combined_objects_cosmos_dbs[each.value.account_lz_key][each.value.account_key].id
  )
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmos_sql_database" {
  for_each = local.cosmosdb_sql_database_roles

  resource_group_name = (
    try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
    try(each.value.resource_group.name, each.value.resource_group_name) :
    local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  )
  account_name = local.combined_objects_cosmos_dbs[try(each.value.account.lz_key, local.client_config.landingzone_key)][try(each.value.account_key, each.value.account.key)].name
  principal_id = (
    each.value.object_id_resource_type == "object_ids" ?
    each.value.object_id_key_resource : each.value.object_id_lz_key == null ?
    local.services_roles[each.value.object_id_resource_type][var.current_landingzone_key][each.value.object_id_key_resource].rbac_id :
    local.services_roles[each.value.object_id_resource_type][each.value.object_id_lz_key][each.value.object_id_key_resource].rbac_id
  )
  role_definition_id = (
    each.value.mode == "custom_role_mapping" ?
    module.cosmosdb_custom_roles[each.value.role_definition_name].id :
    format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.DocumentDB/databaseAccounts/%s/sqlRoleDefinitions/%s",
      local.client_config.subscription_id,
      (
        try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
        try(each.value.resource_group.name, each.value.resource_group_name) :
        local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
      ),
      local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name,
      local.cosmosdb_built_in_roles[lower(each.value.role_definition_name)]
    )
  )
  scope = replace(
    each.value.account_lz_key == null ?
    local.combined_objects_cosmos_dbs[var.current_landingzone_key][each.value.account_key]["sql_databases"][each.value.database_key].id :
    local.combined_objects_cosmos_dbs[each.value.account_lz_key][each.value.account_key]["sql_databases"][each.value.database_key].id,
  "sqlDatabases", "dbs")
}

resource "azurerm_cosmosdb_sql_role_assignment" "cosmos_sql_container" {
  for_each = local.cosmosdb_sql_container_roles

  resource_group_name = (
    try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
    try(each.value.resource_group.name, each.value.resource_group_name) :
    local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
  )
  account_name = local.combined_objects_cosmos_dbs[try(each.value.account.lz_key, local.client_config.landingzone_key)][try(each.value.account_key, each.value.account.key)].name
  principal_id = (
    each.value.object_id_resource_type == "object_ids" ?
    each.value.object_id_key_resource : each.value.object_id_lz_key == null ?
    local.services_roles[each.value.object_id_resource_type][var.current_landingzone_key][each.value.object_id_key_resource].rbac_id :
    local.services_roles[each.value.object_id_resource_type][each.value.object_id_lz_key][each.value.object_id_key_resource].rbac_id
  )
  role_definition_id = (
    each.value.mode == "custom_role_mapping" ?
    module.cosmosdb_custom_roles[each.value.role_definition_name].id :
    format("/subscriptions/%s/resourceGroups/%s/providers/Microsoft.DocumentDB/databaseAccounts/%s/sqlRoleDefinitions/%s",
      local.client_config.subscription_id,
      (
        try(each.value.resource_group.name, null) != null || try(each.value.resource_group_name, null) != null ?
        try(each.value.resource_group.name, each.value.resource_group_name) :
        local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name
      ),
      local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][try(each.value.resource_group_key, each.value.resource_group.key)].name,
      local.cosmosdb_built_in_roles[lower(each.value.role_definition_name)]
    )
  )
  scope = replace(
    replace(
      each.value.account_lz_key == null ?
      local.combined_objects_cosmos_dbs[var.current_landingzone_key][each.value.account_key]["sql_databases"][each.value.database_key]["sql_containers"][each.value.container_key].id :
    local.combined_objects_cosmos_dbs[each.value.account_lz_key][each.value.account_key]["sql_databases"][each.value.database_key]["sql_containers"][each.value.container_key].id, "sqlDatabases", "dbs"), "containers", "colls"
  )
}

locals {
  cosmos_db_assignable_scopes = {
    for k, v in local.database.cosmosdb_role_definitions : k => flatten([
      # accounts
      [
        for attr in try(v.assignable_scopes.cosmos_dbs, {}) : [
          replace(try(attr.id, local.combined_objects_cosmos_dbs[try(attr.lz_key, var.current_landingzone_key)][attr.key].id), "sqlDatabases", "dbs")
        ]
      ],

      # sql databases
      [
        for attr in try(v.assignable_scopes.cosmosdb_sql_databases, {}) : [
          replace(try(attr.id, local.combined_objects_cosmos_dbs[try(attr.lz_key, var.current_landingzone_key)][v.account.key]["sql_databases"][attr.key].id), "sqlDatabases", "dbs")
        ]
      ],

      # sql containers
      [
        for attr in try(v.assignable_scopes.cosmosdb_sql_containers, {}) : [
          replace(
            replace(try(attr.id, local.combined_objects_cosmos_dbs[try(attr.lz_key, var.current_landingzone_key)][v.account.key]["sql_databases"][attr.sql_database.key]["sql_containers"][attr.key].id), "containers", "colls"),
          "sqlDatabases", "dbs")
        ]
      ]
    ])
  }

  # https://learn.microsoft.com/en-us/azure/cosmos-db/how-to-setup-rbac#built-in-role-definitions
  cosmosdb_built_in_roles = {
    lower("Cosmos DB Built-in Data Reader")      = "00000000-0000-0000-0000-000000000001",
    lower("Cosmos DB Built-in Data Contributor") = "00000000-0000-0000-0000-000000000002"
  }

  cosmosdb_account_roles = {
    for mapping in flatten([
      for key_mode, all_role_mapping in local.database.cosmosdb_role_mapping : [
        for account_key, account_role_mappings in try(all_role_mapping.cosmosdb_accounts, {}) : [
          for role_definition_name, resources in account_role_mappings : [
            for object_id_key, object_resources in resources : [
              for object_id_key_resource in object_resources.keys : {
                mode                    = key_mode
                account_key             = account_key
                account_lz_key          = try(account_role_mappings.lz_key, null)
                role_definition_name    = role_definition_name
                object_id_resource_type = object_id_key
                object_id_key_resource  = object_id_key_resource
                object_id_lz_key        = try(object_resources.lz_key, null)
                resource_group          = try(object_resources.resource_group, null)
                resource_group_name     = try(object_resources.resource_group_name, null)
                resource_group_key      = try(object_resources.resource_group_key, null)
              }
            ]
          ] if role_definition_name != "lz_key"
        ]
      ]
    ]) : format("%s_%s_%s_%s", mapping.object_id_resource_type, mapping.account_key, replace(mapping.role_definition_name, " ", "_"), mapping.object_id_key_resource) => mapping
  }

  cosmosdb_sql_database_roles = {
    for mapping in flatten([
      for key_mode, all_role_mapping in local.database.cosmosdb_role_mapping : [
        for database_key, db_role_mappings in try(all_role_mapping.cosmosdb_sql_databases, {}) : [
          for role_definition_name, resources in db_role_mappings : [
            for object_id_key, object_resources in resources : [
              for object_id_key_resource in object_resources.keys : {
                mode                    = key_mode
                database_key            = database_key
                account_key             = db_role_mappings.account_key
                account_lz_key          = try(db_role_mappings.lz_key, null)
                role_definition_name    = role_definition_name
                object_id_resource_type = object_id_key
                object_id_key_resource  = object_id_key_resource
                object_id_lz_key        = try(object_resources.lz_key, null)
                resource_group          = try(object_resources.resource_group, null)
                resource_group_name     = try(object_resources.resource_group_name, null)
                resource_group_key      = try(object_resources.resource_group_key, null)
              }
            ]
          ] if !contains(["lz_key", "account_key"], role_definition_name)
        ]
      ]
    ]) : format("%s_%s_%s_%s", mapping.object_id_resource_type, mapping.database_key, replace(mapping.role_definition_name, " ", "_"), mapping.object_id_key_resource) => mapping
  }

  cosmosdb_sql_container_roles = {
    for mapping in flatten([
      for key_mode, all_role_mapping in local.database.cosmosdb_role_mapping : [
        for container_key, container_role_mappings in try(all_role_mapping.cosmosdb_sql_containers, {}) : [
          for role_definition_name, resources in container_role_mappings : [
            for object_id_key, object_resources in resources : [
              for object_id_key_resource in object_resources.keys : {
                mode                    = key_mode
                container_key           = container_key
                account_key             = container_role_mappings.account_key
                database_key            = container_role_mappings.database_key
                account_lz_key          = try(container_role_mappings.lz_key, null)
                role_definition_name    = role_definition_name
                object_id_resource_type = object_id_key
                object_id_key_resource  = object_id_key_resource
                object_id_lz_key        = try(object_resources.lz_key, null)
                resource_group          = try(object_resources.resource_group, null)
                resource_group_name     = try(object_resources.resource_group_name, null)
                resource_group_key      = try(object_resources.resource_group_key, null)
              }
            ]
          ] if !contains(["lz_key", "account_key", "database_key"], role_definition_name)
        ]
      ]
    ]) : format("%s_%s_%s_%s", mapping.object_id_resource_type, mapping.container_key, replace(mapping.role_definition_name, " ", "_"), mapping.object_id_key_resource) => mapping
  }
}
