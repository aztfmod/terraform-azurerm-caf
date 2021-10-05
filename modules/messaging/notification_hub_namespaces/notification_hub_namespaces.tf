resource "azurecaf_name" "ntfns" {
  name          = var.settings.name
  resource_type = "azurerm_notification_hub_namespace"
  prefixes      = var.global_settings.prefixes
  random_length = var.global_settings.random_length
  clean_input   = true
  passthrough   = var.global_settings.passthrough
  use_slug      = var.global_settings.use_slug
}

resource "azurerm_notification_hub_namespace" "ntfns" {
  name                     = azurecaf_name.ntfns.result
  location                 = var.location
  resource_group_name      = var.resource_group_name
  namespace_type           =  var.settings.namespace_type
  sku_name                 = var.settings.sku_name
  enabled                  = try(var.settings.enabled, true)
  tags                     = local.tags
}
