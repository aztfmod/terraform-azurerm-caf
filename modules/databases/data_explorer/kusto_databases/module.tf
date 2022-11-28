resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_database
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_database

resource "azurerm_kusto_database" "kusto" {
  name                = azurecaf_name.kusto.result
  location            = var.location
  resource_group_name = var.resource_group_name
  cluster_name        = var.cluster_name
  hot_cache_period    = try(var.settings.hot_cache_period, null)
  soft_delete_period  = try(var.settings.soft_delete_period, null)
}