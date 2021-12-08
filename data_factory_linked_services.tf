##### azurerm_data_factory_linked_service_azure_blob_storage
module "data_factory_linked_service_azure_blob_storage" {
  source = "./modules/data_factory/linked_services/azure_blob_storage"

  for_each = local.data_factory.linked_services.azure_blob_storage

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  storage_account = try(local.combined_objects_storage_accounts[try(each.value.storage_account.lz_key, local.client_config.landingzone_key)][each.value.storage_account.key], null)

  integration_runtime_name = try(
    coalesce(
      try(local.combined_objects_data_factory_integration_runtime_self_hosted[each.value.integration_runtime.data_factory_integration_runtime_self_hosted.lz_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
      try(local.combined_objects_data_factory_integration_runtime_self_hosted[local.client_config.landingzone_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
      try(each.value.integration_runtime.data_factory_integration_runtime_self_hosted.name, null),
      try(local.combined_objects_data_factory_integration_runtime_azure_ssis[each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.lz_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
      try(local.combined_objects_data_factory_integration_runtime_azure_ssis[local.client_config.landingzone_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
      try(each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.name, null)
    ),
  null)
}

output "data_factory_linked_service_azure_blob_storage" {
  value = module.data_factory_linked_service_azure_blob_storage
}
##### data_factory_linked_service_cosmosdb
module "data_factory_linked_service_cosmosdb" {
  source = "./modules/data_factory/linked_services/cosmosdb"

  for_each = local.data_factory.linked_services.cosmosdb

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  account_endpoint = coalesce(
    try(local.combined_objects_cosmos_dbs[try(each.value.cosmosdb_account.lz_key, local.client_config.landingzone_key)][each.value.cosmosdb_account.key].endpoint, null),
    try(each.value.cosmosdb_account.endpoint, null)
  )
  account_key = coalesce(
    try(local.combined_objects_cosmos_dbs[try(each.value.cosmosdb_account.lz_key, local.client_config.landingzone_key)][each.value.cosmosdb_account.key].primary_key, null),
    try(each.value.cosmosdb_account.account_key, null)
  )
}

output "data_factory_linked_service_cosmosdb" {
  value = module.data_factory_linked_service_cosmosdb
}
##### data_factory_linked_service_web
module "data_factory_linked_service_web" {
  source = "./modules/data_factory/linked_services/web"

  for_each = local.data_factory.linked_services.web

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}

output "data_factory_linked_service_web" {
  value = module.data_factory_linked_service_web
}
##### data_factory_linked_service_mysql
module "data_factory_linked_service_mysql" {
  source   = "./modules/data_factory/linked_services/mysql"
  for_each = local.data_factory.linked_services.mysql

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
##### data_factory_linked_service_postgresql
module "data_factory_linked_service_postgresql" {
  source   = "./modules/data_factory/linked_services/postgresql"
  for_each = local.data_factory.linked_services.postgresql

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
output "data_factory_linked_service_postgresql" {
  value = module.data_factory_linked_service_postgresql
}
##### data_factory_linked_service_sql_server
module "data_factory_linked_service_sql_server" {
  source   = "./modules/data_factory/linked_services/sql_server"
  for_each = local.data_factory.linked_services.sql_server

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value
  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[try(each.value.resource_group.lz_key, local.client_config.landingzone_key)][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )
  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
output "data_factory_linked_service_sql_server" {
  value = module.data_factory_linked_service_sql_server
}

module "data_factory_linked_service_azure_databricks" {
  source   = "./modules/data_factory/linked_services/azure_databricks"
  for_each = local.data_factory.linked_services.azure_databricks

  global_settings = local.global_settings
  client_config   = local.client_config
  settings        = each.value

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  integration_runtime_name = coalesce(
    try(local.combined_objects_data_factory_integration_runtime_self_hosted[each.value.integration_runtime.data_factory_integration_runtime_self_hosted.lz_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
    try(local.combined_objects_data_factory_integration_runtime_self_hosted[local.client_config.landingzone_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
    try(each.value.integration_runtime.data_factory_integration_runtime_self_hosted.name, null),
    try(local.combined_objects_data_factory_integration_runtime_azure_ssis[each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.lz_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
    try(local.combined_objects_data_factory_integration_runtime_azure_ssis[local.client_config.landingzone_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
    try(each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.name, null)
  )

  remote_objects = {
    databricks_workspace = try(coalesce(
      try(local.combined_objects_databricks_workspaces[each.value.databricks_workspace.lz_key][each.value.databricks_workspace.key], null),
      try(local.combined_objects_databricks_workspaces[local.client_config.landingzone_key][each.value.databricks_workspace.key], null)
    ), null)

    data_factory = try(coalesce(
      try(local.combined_objects_data_factory[each.value.data_factory.lz_key][each.value.data_factory.key], null),
      try(local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory.key], null)
    ), null)
  }
}
output "data_factory_linked_service_azure_databricks" {
  value = module.data_factory_linked_service_azure_databricks
}


module "data_factory_linked_service_key_vault" {
  source   = "./modules/data_factory/linked_services/key_vault"
  for_each = local.data_factory.linked_services.key_vault

  global_settings       = local.global_settings
  client_config         = local.client_config
  settings              = each.value
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  name                  = each.value.name
  additional_properties = try(each.value.additional_properties, null)

  key_vault_id = coalesce(
    try(local.combined_objects_keyvaults[local.client_config.landingzone_key][each.value.keyvault.key].id, null),
    try(local.combined_objects_keyvaults[each.value.keyvault.lz_key][each.value.keyvault.key].id, null),
    try(each.value.keyvault.id, null)
  )

  resource_group_name = coalesce(
    try(local.combined_objects_resource_groups[each.value.resource_group.lz_key][each.value.resource_group.key].name, null),
    try(local.combined_objects_resource_groups[local.client_config.landingzone_key][each.value.resource_group.key].name, null),
    try(each.value.resource_group.name, null)
  )

  data_factory_name = coalesce(
    try(local.combined_objects_data_factory[try(each.value.data_factory.lz_key, local.client_config.landingzone_key)][each.value.data_factory.key].name, null),
    try(each.value.data_factory.name, null)
  )

  integration_runtime_name = coalesce(
    try(local.combined_objects_data_factory_integration_runtime_self_hosted[each.value.integration_runtime.data_factory_integration_runtime_self_hosted.lz_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
    try(local.combined_objects_data_factory_integration_runtime_self_hosted[local.client_config.landingzone_key][each.value.integration_runtime.data_factory_integration_runtime_self_hosted.key].name, null),
    try(each.value.integration_runtime.data_factory_integration_runtime_self_hosted.name, null),
    try(local.combined_objects_data_factory_integration_runtime_azure_ssis[each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.lz_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
    try(local.combined_objects_data_factory_integration_runtime_azure_ssis[local.client_config.landingzone_key][each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.key].name, null),
    try(each.value.integration_runtime.combined_objects_data_factory_integration_runtime_azure_ssis.name, null)
  )

}
output "data_factory_linked_service_key_vault" {
  value = module.data_factory_linked_service_key_vault
}