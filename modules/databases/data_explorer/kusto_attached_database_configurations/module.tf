resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_attached_database_configuration
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_attached_database_configuration

resource "azurerm_kusto_attached_database_configuration" "kusto" {
  name                                = azurecaf_name.kusto.result
  location                            = var.location
  resource_group_name                 = var.resource_group_name
  cluster_name                        = var.cluster_name
  cluster_resource_id                 = var.cluster_resource_id
  database_name                       = var.database_name
  default_principal_modification_kind = try(var.settings.database_name, null)


}