##### azurerm_data_factory_linked_service_azure_blob_storage
module "data_factory_linked_service_azure_blob_storage" {
  source = "./modules/data_factory/linked_services/azure_blob_storage"

  for_each = local.data_factory.linked_services.azure_blob_storage

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  connection_string   = try(each.value.lz_key, null) == null ? local.combined_objects_storage_accounts[local.client_config.landingzone_key][each.value.storage_account_key].name : local.combined_objects_storage_accounts[each.value.lz_key][each.value.storage_account_key].primary_connection_string
}

output "data_factory_linked_service_azure_blob_storage" {
  value = module.data_factory_linked_service_azure_blob_storage
}
##### data_factory_linked_service_cosmosdb
module "data_factory_linked_service_cosmosdb" {
  source = "./modules/data_factory/linked_services/cosmosdb"

  for_each = local.data_factory.linked_services.cosmosdb

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}

output "data_factory_linked_service_cosmosdb" {
  value = module.data_factory_linked_service_cosmosdb
}
##### data_factory_linked_service_web
module "data_factory_linked_service_web" {
  source = "./modules/data_factory/linked_services/web"

  for_each = local.data_factory.linked_services.web

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}

output "data_factory_linked_service_web" {
  value = module.data_factory_linked_service_web
}
##### data_factory_linked_service_mysql
module "data_factory_linked_service_mysql" {
  source   = "./modules/data_factory/linked_services/mysql"
  for_each = local.data_factory.linked_services.mysql

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
##### data_factory_linked_service_postgresql
module "data_factory_linked_service_postgresql" {
  source   = "./modules/data_factory/linked_services/postgresql"
  for_each = local.data_factory.linked_services.postgresql

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
output "data_factory_linked_service_postgresql" {
  value = module.data_factory_linked_service_postgresql
}
##### data_factory_linked_service_sql_server
module "data_factory_linked_service_sql_server" {
  source   = "./modules/data_factory/linked_services/sql_server"
  for_each = local.data_factory.linked_services.sql_server

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  #connection_string = try(each.value.lz_key, null) == null ? local.combined_objects_cosmos_dbs[local.client_config.landingzone_key][each.value.cosmos_db_key].name : local.combined_objects_cosmos_dbs[each.value.lz_key][each.value.cosmos_db_key].connection_string
}
output "data_factory_linked_service_sql_server" {
  value = module.data_factory_linked_service_sql_server
}