resource "azurecaf_name" "evhcg_name" {
  name          = var.settings.name
  resource_type = "azurerm_eventhub_consumer_group"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

# Last reviewed :  AzureRM version 2.64.0
# Ref : https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/eventhub_consumer_group

resource "azurerm_eventhub_consumer_group" "evhcg" {
  name                = azurecaf_name.evhcg_name.result
  namespace_name      = var.namespace_name
  eventhub_name       = var.eventhub_name
  resource_group_name = var.resource_group.name
  user_metadata       = try(var.settings.user_metadata, null)
}