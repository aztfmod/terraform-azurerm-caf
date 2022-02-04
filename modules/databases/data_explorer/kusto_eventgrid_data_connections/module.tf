resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_eventgrid_data_connection
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_eventgrid_data_connection

resource "azurerm_kusto_eventgrid_data_connection" "kusto" {
  name                         = azurecaf_name.kusto.result
  location                     = var.location
  resource_group_name          = var.resource_group_name
  cluster_name                 = var.cluster_name
  database_name                = var.database_name
  storage_account_id           = var.storage_account_id
  eventhub_id                  = var.eventhub_id
  eventhub_consumer_group_name = try(var.settings.eventhub_consumer_group_name, null)
  blob_storage_event_type      = try(var.settings.blob_storage_event_type, null)
  data_format                  = try(var.settings.data_format, null)
  mapping_rule_name            = try(var.settings.mapping_rule_name, null)
  table_name                   = try(var.settings.table_name, null)
  skip_first_record            = try(var.settings.skip_first_record, null)
}