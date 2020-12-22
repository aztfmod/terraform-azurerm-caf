##### azurerm_data_factory
module "data_factory_dataset_azure_blob" {
  source = "./modules/data_factory/datasets/azure_blob"

  for_each = local.data_factory.datasets.azure_blob

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key]
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  path                  = each.value.path
  filename              = each.value.filename
}

output "data_factory_dataset_azure_blob" {
  value = module.data_factory_dataset_azure_blob
}

##### azurerm_data_factory_dataset_cosmosdb_sqlapi
module "data_factory_dataset_cosmosdb_sqlapi" {
  source = "./modules/data_factory/datasets/cosmosdb_sqlapi"

  for_each = local.data_factory.datasets.cosmosdb_sqlapi

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  collection_name       = try(each.value.collection_name, null)
}

output "data_factory_dataset_cosmosdb_sqlapi" {
  value = module.data_factory_dataset_cosmosdb_sqlapi
}

##### azurerm_data_factory_dataset_delimited_text
module "data_factory_dataset_delimited_text" {
  source = "./modules/data_factory/datasets/delimited_text"

  for_each = local.data_factory.datasets.delimited_text

  name                        = each.value.name
  resource_group_name         = module.resource_groups[each.value.resource_group_key].name
  data_factory_name           = module.data_factory[each.value.data_factory_key].name
  linked_service_name         = local.data_factory.linked_services[each.value.linked_service_key]
  folder                      = try(each.value.folder, null)
  description                 = try(each.value.description, null)
  annotations                 = try(each.value.annotations, null)
  parameters                  = try(each.value.parameters, null)
  additional_properties       = try(each.value.additional_properties, null)
  schema_column               = try(each.value.schema_column, null)
  http_server_location        = try(each.value.http_server_location, null)
  azure_blob_storage_location = try(each.value.azure_blob_storage_location, null)
  column_delimiter            = each.value.column_delimiter
  row_delimiter               = each.value.row_delimiter
  encoding                    = each.value.encoding
  quote_character             = each.value.quote_character
  escape_character            = each.value.escape_character
  first_row_as_header         = each.value.first_row_as_header
  null_value                  = each.value.null_value
}

output "data_factory_dataset_delimited_text" {
  value = module.data_factory_dataset_delimited_text
}

##### azurerm_data_factory_dataset_http
module "data_factory_dataset_http" {
  source = "./modules/data_factory/datasets/http"

  for_each = local.data_factory.datasets.http

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  relative_url          = each.value.relative_url
  request_body          = each.value.request_body
  request_method        = each.value.request_method
}

output "data_factory_dataset_http" {
  value = module.data_factory_dataset_http
}

##### azurerm_data_factory_dataset_json
module "data_factory_dataset_json" {
  source = "./modules/data_factory/datasets/json"

  for_each = local.data_factory.datasets.json

  name                        = each.value.name
  resource_group_name         = module.resource_groups[each.value.resource_group_key].name
  data_factory_name           = module.data_factory[each.value.data_factory_key].name
  linked_service_name         = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                      = try(each.value.folder, null)
  description                 = try(each.value.description, null)
  annotations                 = try(each.value.annotations, null)
  parameters                  = try(each.value.parameters, null)
  additional_properties       = try(each.value.additional_properties, null)
  schema_column               = try(each.value.schema_column, null)
  http_server_location        = try(each.value.http_server_location, null)
  azure_blob_storage_location = try(each.value.azure_blob_storage_location, null)
  encoding                    = each.value.encoding
}

output "data_factory_dataset_json" {
  value = module.data_factory_dataset_json
}

##### azurerm_data_factory_dataset_mysql
module "data_factory_dataset_mysql" {
  source = "./modules/data_factory/datasets/mysql"

  for_each = local.data_factory.datasets.mysql

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  table_name            = try(each.value.table_name, null)
}

output "data_factory_dataset_mysql" {
  value = module.data_factory_dataset_mysql
}

##### azurerm_data_factory_dataset_postgresql
module "data_factory_dataset_postgresql" {
  source = "./modules/data_factory/datasets/postgresql"

  for_each = local.data_factory.datasets.postgresql

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  table_name            = try(each.value.table_name, null)
}

output "data_factory_dataset_postgresql" {
  value = module.data_factory_dataset_postgresql
}

##### azurerm_data_factory_dataset_sql_server_table
module "data_factory_dataset_sql_server_table" {
  source = "./modules/data_factory/datasets/sql_server_table"

  for_each = local.data_factory.datasets.sql_server_table

  name                  = each.value.name
  resource_group_name   = module.resource_groups[each.value.resource_group_key].name
  data_factory_name     = module.data_factory[each.value.data_factory_key].name
  linked_service_name   = local.data_factory.linked_services[each.value.linked_service_key].name
  folder                = try(each.value.folder, null)
  description           = try(each.value.description, null)
  annotations           = try(each.value.annotations, null)
  parameters            = try(each.value.parameters, null)
  additional_properties = try(each.value.additional_properties, null)
  schema_column         = try(each.value.schema_column, null)
  table_name            = try(each.value.table_name, null)
}

output "data_factory_dataset_sql_server_table" {
  value = module.data_factory_dataset_sql_server_table
}