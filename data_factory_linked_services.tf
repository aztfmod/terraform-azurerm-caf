##### azurerm_data_factory_linked_service_azure_blob_storage
module "data_factory_linked_service_azure_blob_storage" {
  source = "./modules/data_factory/linked_services/azure_blob_storage"

  for_each = local.data_factory.linked_services.azure_blob_storage

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "data_factory_linked_service_azure_blob_storage" {
  value = module.data_factory_linked_service_azure_blob_storage
}

##### azurerm_data_factory_linked_service_azure_file_storage
module "azurerm_data_factory_linked_service_azure_file_storage" {
  source = "./modules/data_factory/linked_services/azure_file_storage"

  for_each = local.data_factory.linked_services.azure_file_storage

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_azure_file_storage" {
  value = module.azurerm_data_factory_linked_service_azure_file_storage
}


##### azurerm_data_factory_linked_service_azure_function
module "azurerm_data_factory_linked_service_azure_function" {
  source = "./modules/data_factory/linked_services/azure_function"

  for_each = local.data_factory.linked_services.azure_function

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  url                      = each.value.url
  key                      = each.value.key
}

output "azurerm_data_factory_linked_service_azure_function" {
  value = module.azurerm_data_factory_linked_service_azure_function
}


##### azurerm_data_factory_linked_service_azure_sql_database
module "azurerm_data_factory_linked_service_azure_sql_database" {
  source = "./modules/data_factory/linked_services/azure_sql_database"

  for_each = local.data_factory.linked_services.azure_sql_database

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_azure_sql_database" {
  value = module.azurerm_data_factory_linked_service_azure_sql_database
}


##### azurerm_data_factory_linked_service_cosmosdb
module "azurerm_data_factory_linked_service_cosmosdb" {
  source = "./modules/data_factory/linked_services/cosmosdb"

  for_each = local.data_factory.linked_services.cosmosdb

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_cosmosdb" {
  value = module.azurerm_data_factory_linked_service_cosmosdb
}

##### azurerm_data_factory_linked_service_data_lake_storage_gen2
module "azurerm_data_factory_linked_service_data_lake_storage_gen2" {
  source = "./modules/data_factory/linked_services/data_lake_storage_gen2"

  for_each = local.data_factory.linked_services.data_lake_storage_gen2

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_data_lake_storage_gen2" {
  value = module.azurerm_data_factory_linked_service_data_lake_storage_gen2
}

##### azurerm_data_factory_linked_service_key_vault
module "azurerm_data_factory_linked_service_key_vault" {
  source = "./modules/data_factory/linked_services/key_vault"

  for_each = local.data_factory.linked_services.key_vault

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_key_vault" {
  value = module.azurerm_data_factory_linked_service_key_vault
}


##### azurerm_data_factory_linked_service_mysql
module "azurerm_data_factory_linked_service_mysql" {
  source = "./modules/data_factory/linked_services/mysql"

  for_each = local.data_factory.linked_services.mysql

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_mysql" {
  value = module.azurerm_data_factory_linked_service_mysql
}


##### azurerm_data_factory_linked_service_postgresql
module "azurerm_data_factory_linked_service_postgresql" {
  source = "./modules/data_factory/linked_services/postgresql"

  for_each = local.data_factory.linked_services.postgresql

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_postgresql" {
  value = module.azurerm_data_factory_linked_service_postgresql
}


##### azurerm_data_factory_linked_service_sftp
module "azurerm_data_factory_linked_service_sftp" {
  source = "./modules/data_factory/linked_services/sftp"

  for_each = local.data_factory.linked_services.sftp

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_sftp" {
  value = module.azurerm_data_factory_linked_service_sftp
}

##### azurerm_data_factory_linked_service_sql_server
module "azurerm_data_factory_linked_service_sql_server" {
  source = "./modules/data_factory/linked_services/sql_server"

  for_each = local.data_factory.linked_services.sql_server

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_sql_server" {
  value = module.azurerm_data_factory_linked_service_sql_server
}


##### azurerm_data_factory_linked_service_web
module "azurerm_data_factory_linked_service_web" {
  source = "./modules/data_factory/linked_services/web"

  for_each = local.data_factory.linked_services.web

  name                     = each.value.name
  resource_group_name      = module.resource_groups[each.value.resource_group_key].name
  data_factory_name        = module.data_factory[each.value.data_factory_key].name
  description              = try(each.value.description, null)
  integration_runtime_name = try(each.value.integration_runtime_name, null)
  annotations              = try(each.value.annotations, null)
  parameters               = try(each.value.parameters, null)
  additional_properties    = try(each.value.additional_properties, null)
  connection_string        = module.storage_accounts[each.value.storage_account_key].primary_connection_string
}

output "azurerm_data_factory_linked_service_web" {
  value = module.azurerm_data_factory_linked_service_web
}
