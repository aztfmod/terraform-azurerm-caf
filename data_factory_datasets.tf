##### azurerm_data_factory
module "data_factory_dataset_azure_blob" {
  source   = "./modules/data_factory/datasets/azure_blob"
  for_each = local.data_factory.datasets.azure_blob

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_azure_blob_storage[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_azure_blob_storage[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_azure_blob" {
  value = module.data_factory_dataset_azure_blob
}

##### azurerm_data_factory_dataset_cosmosdb_sqlapi
module "data_factory_dataset_cosmosdb_sqlapi" {
  source = "./modules/data_factory/datasets/cosmosdb_sqlapi"

  for_each = local.data_factory.datasets.cosmosdb_sqlapi

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_cosmosdb[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_cosmosdb[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_cosmosdb_sqlapi" {
  value = module.data_factory_dataset_cosmosdb_sqlapi
}

##### azurerm_data_factory_dataset_delimited_text
module "data_factory_dataset_delimited_text" {
  source = "./modules/data_factory/datasets/delimited_text"

  for_each = local.data_factory.datasets.delimited_text

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_web[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_web[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_delimited_text" {
  value = module.data_factory_dataset_delimited_text
}

##### azurerm_data_factory_dataset_http
module "data_factory_dataset_http" {
  source   = "./modules/data_factory/datasets/http"
  for_each = local.data_factory.datasets.http

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_web[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_web[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_http" {
  value = module.data_factory_dataset_http
}

##### azurerm_data_factory_dataset_json
module "data_factory_dataset_json" {
  source   = "./modules/data_factory/datasets/json"
  for_each = local.data_factory.datasets.json

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_web[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_web[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_json" {
  value = module.data_factory_dataset_json
}

##### azurerm_data_factory_dataset_mysql
module "data_factory_dataset_mysql" {
  source   = "./modules/data_factory/datasets/mysql"
  for_each = local.data_factory.datasets.mysql

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_mysql[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_mysql[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_mysql" {
  value = module.data_factory_dataset_mysql
}

##### azurerm_data_factory_dataset_postgresql
module "data_factory_dataset_postgresql" {
  source   = "./modules/data_factory/datasets/postgresql"
  for_each = local.data_factory.datasets.postgresql

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_postgresql[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_postgresql[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_postgresql" {
  value = module.data_factory_dataset_postgresql
}

##### azurerm_data_factory_dataset_sql_server_table
module "data_factory_dataset_sql_server_table" {
  source = "./modules/data_factory/datasets/sql_server_table"

  for_each = local.data_factory.datasets.sql_server_table

  global_settings     = local.global_settings
  client_config       = local.client_config
  settings            = each.value
  resource_group_name = local.resource_groups[each.value.resource_group_key].name
  data_factory_name   = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory[local.client_config.landingzone_key][each.value.data_factory_key].name : local.combined_objects_data_factory[each.value.lz_key][each.value.data_factory_key].name
  linked_service_name = try(each.value.lz_key, null) == null ? local.combined_objects_data_factory_linked_service_sql_server[local.client_config.landingzone_key][each.value.linked_service_key].name : local.combined_objects_data_factory_linked_service_sql_server[each.value.lz_key][each.value.linked_service_key].name
}

output "data_factory_dataset_sql_server_table" {
  value = module.data_factory_dataset_sql_server_table
}