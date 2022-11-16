resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_eventhub_data_connection
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_iothub_data_connection

resource "azurerm_kusto_iothub_data_connection" "kusto" {
  name                      = azurecaf_name.kusto.result
  location                  = var.location
  resource_group_name       = var.resource_group_name
  cluster_name              = var.cluster_name
  database_name             = var.database_name
  iothub_id                 = var.iothub_id
  consumer_group            = var.settings.consumer_group
  shared_access_policy_name = try(var.settings.shared_access_policy_name, null)
  event_system_properties   = try(var.settings.event_system_properties, null)
  table_name                = try(var.settings.table_name, null)
  mapping_rule_name         = try(var.settings.mapping_rule_name, null)
  data_format               = try(var.settings.data_format, null)
}