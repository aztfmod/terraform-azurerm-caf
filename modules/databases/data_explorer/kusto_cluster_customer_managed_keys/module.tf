resource "azurecaf_name" "kusto" {
  name          = var.settings.name
  resource_type = "azurerm_kusto_cluster" #azurerm_kusto_cluster_customer_managed_key
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last review :  AzureRM version 2.77.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/kusto_cluster_customer_managed_key

resource "azurerm_kusto_cluster_customer_managed_key" "kusto" {
  name          = azurecaf_name.kusto.result
  location      = var.location
  key_vault_id  = var.key_vault_id
  key_name      = var.key_name
  key_version   = var.key_version
  user_identity = try(var.user_identity, null)
}